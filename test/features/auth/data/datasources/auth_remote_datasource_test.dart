import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_bloc_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:supabase_bloc_app/features/auth/data/models/user_model.dart';

class _MockSupabaseClient extends Mock implements SupabaseClient {}
class _MockGoTrueClient extends Mock implements GoTrueClient {}
class _MockAuthResponse extends Mock implements AuthResponse {}
class _MockUser extends Mock implements User {}

void main() {
  late _MockSupabaseClient mockClient;
  late _MockGoTrueClient mockAuth;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    mockClient = _MockSupabaseClient();
    mockAuth = _MockGoTrueClient();
    when(() => mockClient.auth).thenReturn(mockAuth);
    dataSource = AuthRemoteDataSourceImpl(mockClient);
  });

  group('AuthRemoteDataSourceImpl', () {
    test('login returns UserModel when user present', () async {
      final response = _MockAuthResponse();
      final user = _MockUser();

      when(() => mockAuth.signInWithPassword(email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) async => response);
      when(() => response.user).thenReturn(user);
      when(() => user.toJson()).thenReturn({'id': 'uid-1', 'email': 'a@b.c'});

      final UserModel result = await dataSource.login('a@b.c', 'secret');

      expect(result.id, 'uid-1');
      expect(result.email, 'a@b.c');
      verify(() => mockAuth.signInWithPassword(email: 'a@b.c', password: 'secret')).called(1);
    });

    test('login throws when user is null', () async {
      final response = _MockAuthResponse();

      when(() => mockAuth.signInWithPassword(email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) async => response);
      when(() => response.user).thenReturn(null);

      expect(
        () => dataSource.login('x@y.z', 'pw'),
        throwsA(isA<Exception>()),
      );
    });

    test('logout delegates to client.auth.signOut', () async {
      when(() => mockAuth.signOut()).thenAnswer((_) async {});

      await dataSource.logout();

      verify(() => mockAuth.signOut()).called(1);
    });

    test('getCurrentUser returns UserModel when currentUser present', () async {
      final user = _MockUser();
      when(() => mockAuth.currentUser).thenReturn(user);
      when(() => user.toJson()).thenReturn({'id': 'u9', 'email': 'z@z.z'});

      final result = await dataSource.getCurrentUser();

      expect(result, isA<UserModel>());
      expect(result?.id, 'u9');
      expect(result?.email, 'z@z.z');
    });

    test('getCurrentUser returns null when no user', () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      final result = await dataSource.getCurrentUser();

      expect(result, isNull);
    });
  });
}


