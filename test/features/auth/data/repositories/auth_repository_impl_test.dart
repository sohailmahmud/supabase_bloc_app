import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:supabase_bloc_app/features/auth/data/models/user_model.dart';
import 'package:supabase_bloc_app/features/auth/data/repositories/auth_repository_impl.dart';

class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late _MockAuthRemoteDataSource mockRemote;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockRemote = _MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemote);
  });

  group('AuthRepositoryImpl', () {
    test('login returns user id', () async {
      const user = UserModel(id: 'uid-123', email: 'test@example.com');
      when(() => mockRemote.login('test@example.com', 'secret'))
          .thenAnswer((_) async => user);

      final result = await repository.login(
        email: 'test@example.com',
        password: 'secret',
      );

      expect(result, 'uid-123');
      verify(() => mockRemote.login('test@example.com', 'secret')).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('logout delegates to remote', () async {
      when(() => mockRemote.logout()).thenAnswer((_) async {});

      await repository.logout();

      verify(() => mockRemote.logout()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('getCurrentUserId returns id when user exists', () async {
      const user = UserModel(id: 'u1', email: 'a@b.c');
      when(() => mockRemote.getCurrentUser()).thenAnswer((_) async => user);

      final result = await repository.getCurrentUserId();

      expect(result, 'u1');
      verify(() => mockRemote.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('getCurrentUserId returns null when no user', () async {
      when(() => mockRemote.getCurrentUser()).thenAnswer((_) async => null);

      final result = await repository.getCurrentUserId();

      expect(result, isNull);
      verify(() => mockRemote.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}


