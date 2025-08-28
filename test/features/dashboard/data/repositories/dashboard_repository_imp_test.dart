import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:supabase_bloc_app/features/dashboard/data/models/profile_model.dart';
import 'package:supabase_bloc_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/entities/profile_entity.dart';

class _MockDashboardRemoteDataSource extends Mock implements DashboardRemoteDataSource {}

void main() {
  late _MockDashboardRemoteDataSource mockRemote;
  late DashboardRepositoryImpl repository;

  setUp(() {
    mockRemote = _MockDashboardRemoteDataSource();
    repository = DashboardRepositoryImpl(mockRemote);
  });

  group('DashboardRepositoryImpl', () {
    group('getProfile', () {
      const userId = 'user-123';
      const username = 'testuser';
      final createdAt = DateTime(2024, 1, 1, 12, 30, 45);

      test('returns ProfileEntity when profile exists', () async {
        // Arrange
        final profileModel = ProfileModel(
          id: userId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRemote.getProfile(userId))
            .thenAnswer((_) async => profileModel);

        // Act
        final result = await repository.getProfile(userId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.id, userId);
        expect(result?.username, username);
        expect(result?.createdAt, createdAt);
        verify(() => mockRemote.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('returns null when profile does not exist', () async {
        // Arrange
        when(() => mockRemote.getProfile(userId))
            .thenAnswer((_) async => null);

        // Act
        final result = await repository.getProfile(userId);

        // Assert
        expect(result, isNull);
        verify(() => mockRemote.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('handles different user IDs correctly', () async {
        // Arrange
        const differentUserId = 'user-456';
        const differentUsername = 'differentuser';
        final differentCreatedAt = DateTime(2024, 2, 1, 15, 45, 30);
        
        final profileModel = ProfileModel(
          id: differentUserId,
          username: differentUsername,
          createdAt: differentCreatedAt,
        );
        when(() => mockRemote.getProfile(differentUserId))
            .thenAnswer((_) async => profileModel);

        // Act
        final result = await repository.getProfile(differentUserId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.id, differentUserId);
        expect(result?.username, differentUsername);
        expect(result?.createdAt, differentCreatedAt);
        verify(() => mockRemote.getProfile(differentUserId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('handles empty string values correctly', () async {
        // Arrange
        final profileModel = ProfileModel(
          id: '',
          username: '',
          createdAt: createdAt,
        );
        when(() => mockRemote.getProfile(userId))
            .thenAnswer((_) async => profileModel);

        // Act
        final result = await repository.getProfile(userId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.id, '');
        expect(result?.username, '');
        expect(result?.createdAt, createdAt);
        verify(() => mockRemote.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('handles special characters in username correctly', () async {
        // Arrange
        const specialUsername = 'test@user#123!';
        final profileModel = ProfileModel(
          id: userId,
          username: specialUsername,
          createdAt: createdAt,
        );
        when(() => mockRemote.getProfile(userId))
            .thenAnswer((_) async => profileModel);

        // Act
        final result = await repository.getProfile(userId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.username, specialUsername);
        verify(() => mockRemote.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('delegates to remote datasource correctly', () async {
        // Arrange
        final profileModel = ProfileModel(
          id: userId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRemote.getProfile(userId))
            .thenAnswer((_) async => profileModel);

        // Act
        await repository.getProfile(userId);

        // Assert
        verify(() => mockRemote.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('propagates errors from remote datasource', () async {
        // Arrange
        const errorMessage = 'Database connection failed';
        when(() => mockRemote.getProfile(userId))
            .thenThrow(Exception(errorMessage));

        // Act & Assert
        expect(
          () => repository.getProfile(userId),
          throwsA(isA<Exception>()),
        );
        verify(() => mockRemote.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('propagates network errors from remote datasource', () async {
        // Arrange
        const errorMessage = 'Network timeout';
        when(() => mockRemote.getProfile(userId))
            .thenThrow(Exception(errorMessage));

        // Act & Assert
        expect(
          () => repository.getProfile(userId),
          throwsA(isA<Exception>()),
        );
        verify(() => mockRemote.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('returns ProfileEntity with correct type when using ProfileModel', () async {
        // Arrange
        final profileModel = ProfileModel(
          id: userId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRemote.getProfile(userId))
            .thenAnswer((_) async => profileModel);

        // Act
        final result = await repository.getProfile(userId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result, isA<ProfileModel>());
        expect(result?.runtimeType, ProfileModel);
        verify(() => mockRemote.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });
    });
  });
}
