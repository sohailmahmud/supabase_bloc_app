import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_bloc_app/features/auth/domain/repositories/auth_repository.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(AuthLogin(email: '', password: ''));
  });

  Widget _wrapWithBloc(AuthRepository repo) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AuthBloc(authRepository: repo),
        child: const LoginPage(),
      ),
    );
  }

  testWidgets('shows validation errors when fields are empty', (tester) async {
    final repo = _MockAuthRepository();
    await tester.pumpWidget(_wrapWithBloc(repo));

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
  });

  testWidgets('dispatches login and calls repository on valid input', (tester) async {
    final repo = _MockAuthRepository();
    when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => 'uid-123');

    await tester.pumpWidget(_wrapWithBloc(repo));

    await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret');

    await tester.tap(find.text('Login'));
    await tester.pump();

    verify(() => repo.login(email: 'user@example.com', password: 'secret')).called(1);
  });

  testWidgets('shows SnackBar on AuthFailure', (tester) async {
    final repo = _MockAuthRepository();
    when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
        .thenThrow(Exception('Login failed'));

    await tester.pumpWidget(_wrapWithBloc(repo));

    await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong');

    await tester.tap(find.text('Login'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('Exception: Login failed'), findsOneWidget);
  });
}


