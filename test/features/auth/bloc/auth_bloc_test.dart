import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  test('initial state is AuthInitial', () {
    expect(authBloc.state, AuthInitial());
  });

  test('emits AuthLoading and AuthSuccess on successful login', () async {
    when(() => mockAuthRepository.login(
        email: 'test@test.com',
        password: '123456')).thenAnswer((_) async => 'user_id_123');

    final expectedStates = [
      AuthLoading(),
      AuthSuccess(userId: 'user_id_123'),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(AuthLogin(email: 'test@test.com', password: '123456'));
  });

  test('emits AuthLoading and AuthFailure on failed login', () async {
    when(() =>
            mockAuthRepository.login(email: 'test@test.com', password: 'wrong'))
        .thenThrow(Exception('Login failed'));

    final expectedStates = [
      AuthLoading(),
      isA<AuthFailure>(),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(AuthLogin(email: 'test@test.com', password: 'wrong'));
  });
}
