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

  Widget wrapWithBloc(AuthRepository repo) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AuthBloc(authRepository: repo),
        child: const LoginPage(),
      ),
    );
  }

  testWidgets('shows validation errors when fields are empty', (tester) async {
    final repo = _MockAuthRepository();
    await tester.pumpWidget(wrapWithBloc(repo));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
  });

  testWidgets('dispatches login and calls repository on valid input', (tester) async {
    final repo = _MockAuthRepository();
    when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => 'uid-123');

    await tester.pumpWidget(wrapWithBloc(repo));

    await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    verify(() => repo.login(email: 'user@example.com', password: 'secret')).called(1);
  });

  testWidgets('shows SnackBar on AuthFailure', (tester) async {
    final repo = _MockAuthRepository();
    when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
        .thenThrow(Exception('Login failed'));

    await tester.pumpWidget(wrapWithBloc(repo));

    await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Allow time for bloc to emit and SnackBar to appear (animations)
    var attempts = 0;
    const maxAttempts = 10;
    while (attempts < maxAttempts && find.textContaining('Login failed').evaluate().isEmpty) {
      await tester.pump(const Duration(milliseconds: 100));
      attempts++;
    }

    expect(find.textContaining('Login failed'), findsOneWidget);
  });
}


