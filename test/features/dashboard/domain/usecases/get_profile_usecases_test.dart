import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/entities/profile_entity.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/usecases/get_profile_usecase.dart';

class _MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  late _MockDashboardRepository mockRepository;
  late GetProfileUseCase useCase;

  setUp(() {
    mockRepository = _MockDashboardRepository();
    useCase = GetProfileUseCase(mockRepository);
  });

  group('GetProfileUseCase', () {
    group('call', () {
      const userId = 'user-123';
      const username = 'testuser';
      final createdAt = DateTime(2024, 1, 1, 12, 30, 45);

      test('returns ProfileEntity when profile exists', () async {
        // Arrange
        final profileEntity = ProfileEntity(
          id: userId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRepository.getProfile(userId))
            .thenAnswer((_) async => profileEntity);

        // Act
        final result = await useCase(userId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.id, userId);
        expect(result?.username, username);
        expect(result?.createdAt, createdAt);
        verify(() => mockRepository.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('returns null when profile does not exist', () async {
        // Arrange
        when(() => mockRepository.getProfile(userId))
            .thenAnswer((_) async => null);

        // Act
        final result = await useCase(userId);

        // Assert
        expect(result, isNull);
        verify(() => mockRepository.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('handles different user IDs correctly', () async {
        // Arrange
        const differentUserId = 'user-456';
        const differentUsername = 'differentuser';
        final differentCreatedAt = DateTime(2024, 2, 1, 15, 45, 30);
        
        final profileEntity = ProfileEntity(
          id: differentUserId,
          username: differentUsername,
          createdAt: differentCreatedAt,
        );
        when(() => mockRepository.getProfile(differentUserId))
            .thenAnswer((_) async => profileEntity);

        // Act
        final result = await useCase(differentUserId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.id, differentUserId);
        expect(result?.username, differentUsername);
        expect(result?.createdAt, differentCreatedAt);
        verify(() => mockRepository.getProfile(differentUserId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('handles empty string user ID', () async {
        // Arrange
        const emptyUserId = '';
        final profileEntity = ProfileEntity(
          id: emptyUserId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRepository.getProfile(emptyUserId))
            .thenAnswer((_) async => profileEntity);

        // Act
        final result = await useCase(emptyUserId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.id, '');
        verify(() => mockRepository.getProfile(emptyUserId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('handles very long user ID', () async {
        // Arrange
        final longUserId = 'a'.padRight(1000, 'a'); // 1000 character ID
        final profileEntity = ProfileEntity(
          id: longUserId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRepository.getProfile(longUserId))
            .thenAnswer((_) async => profileEntity);

        // Act
        final result = await useCase(longUserId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.id.length, 1000);
        verify(() => mockRepository.getProfile(longUserId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('handles special characters in user ID', () async {
        // Arrange
        const specialUserId = 'user@123#456!';
        final profileEntity = ProfileEntity(
          id: specialUserId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRepository.getProfile(specialUserId))
            .thenAnswer((_) async => profileEntity);

        // Act
        final result = await useCase(specialUserId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.id, specialUserId);
        verify(() => mockRepository.getProfile(specialUserId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('delegates to repository correctly', () async {
        // Arrange
        final profileEntity = ProfileEntity(
          id: userId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRepository.getProfile(userId))
            .thenAnswer((_) async => profileEntity);

        // Act
        await useCase(userId);

        // Assert
        verify(() => mockRepository.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('propagates exceptions from repository', () async {
        // Arrange
        const errorMessage = 'Database connection failed';
        when(() => mockRepository.getProfile(userId))
            .thenThrow(Exception(errorMessage));

        // Act & Assert
        expect(
          () => useCase(userId),
          throwsA(isA<Exception>()),
        );
        verify(() => mockRepository.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('propagates network errors from repository', () async {
        // Arrange
        const errorMessage = 'Network timeout';
        when(() => mockRepository.getProfile(userId))
            .thenThrow(Exception(errorMessage));

        // Act & Assert
        expect(
          () => useCase(userId),
          throwsA(isA<Exception>()),
        );
        verify(() => mockRepository.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('propagates authentication errors from repository', () async {
        // Arrange
        const errorMessage = 'Unauthorized access';
        when(() => mockRepository.getProfile(userId))
            .thenThrow(Exception(errorMessage));

        // Act & Assert
        expect(
          () => useCase(userId),
          throwsA(isA<Exception>()),
        );
        verify(() => mockRepository.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('returns ProfileEntity with correct type', () async {
        // Arrange
        final profileEntity = ProfileEntity(
          id: userId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRepository.getProfile(userId))
            .thenAnswer((_) async => profileEntity);

        // Act
        final result = await useCase(userId);

        // Assert
        expect(result, isA<ProfileEntity>());
        expect(result?.runtimeType, ProfileEntity);
        verify(() => mockRepository.getProfile(userId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('handles multiple consecutive calls correctly', () async {
        // Arrange
        final profileEntity = ProfileEntity(
          id: userId,
          username: username,
          createdAt: createdAt,
        );
        when(() => mockRepository.getProfile(userId))
            .thenAnswer((_) async => profileEntity);

        // Act
        final result1 = await useCase(userId);
        final result2 = await useCase(userId);

        // Assert
        expect(result1, isA<ProfileEntity>());
        expect(result2, isA<ProfileEntity>());
        expect(result1?.id, userId);
        expect(result2?.id, userId);
        verify(() => mockRepository.getProfile(userId)).called(2);
        verifyNoMoreInteractions(mockRepository);
      });
    });
  });
}
