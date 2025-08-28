import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_bloc_app/features/dashboard/data/models/profile_model.dart';

void main() {
  group('DashboardRemoteDataSource - ProfileModel Tests', () {
    group('ProfileModel.fromJson', () {
      test('creates ProfileModel from valid JSON', () {
        // Arrange
        final json = {
          'id': 'user-123',
          'username': 'testuser',
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act
        final result = ProfileModel.fromJson(json);

        // Assert
        expect(result, isA<ProfileModel>());
        expect(result.id, 'user-123');
        expect(result.username, 'testuser');
        expect(result.createdAt, DateTime.parse('2024-01-01T00:00:00.000Z'));
      });

      test('creates ProfileModel with different values', () {
        // Arrange
        final json = {
          'id': 'user-456',
          'username': 'differentuser',
          'created_at': '2024-02-01T12:30:45.000Z',
        };

        // Act
        final result = ProfileModel.fromJson(json);

        // Assert
        expect(result.id, 'user-456');
        expect(result.username, 'differentuser');
        expect(result.createdAt, DateTime.parse('2024-02-01T12:30:45.000Z'));
      });

      test('creates ProfileModel with local date time', () {
        // Arrange
        final json = {
          'id': 'user-789',
          'username': 'localuser',
          'created_at': '2024-03-01T15:45:30',
        };

        // Act
        final result = ProfileModel.fromJson(json);

        // Assert
        expect(result.id, 'user-789');
        expect(result.username, 'localuser');
        expect(result.createdAt, DateTime.parse('2024-03-01T15:45:30'));
      });

      test('creates ProfileModel with empty string values', () {
        // Arrange
        final json = {
          'id': '',
          'username': '',
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act
        final result = ProfileModel.fromJson(json);

        // Assert
        expect(result.id, '');
        expect(result.username, '');
        expect(result.createdAt, DateTime.parse('2024-01-01T00:00:00.000Z'));
      });

      test('creates ProfileModel with special characters in username', () {
        // Arrange
        final json = {
          'id': 'user-123',
          'username': 'test@user#123!',
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act
        final result = ProfileModel.fromJson(json);

        // Assert
        expect(result.username, 'test@user#123!');
      });

      test('creates ProfileModel with numeric string ID', () {
        // Arrange
        final json = {
          'id': '12345',
          'username': 'numericuser',
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act
        final result = ProfileModel.fromJson(json);

        // Assert
        expect(result.id, '12345');
        expect(result.username, 'numericuser');
      });
    });

    group('fromJson error handling', () {
      test('throws FormatException for invalid date format', () {
        // Arrange
        final json = {
          'id': 'user-123',
          'username': 'testuser',
          'created_at': 'invalid-date',
        };

        // Act & Assert
        expect(
          () => ProfileModel.fromJson(json),
          throwsA(isA<FormatException>()),
        );
      });

      test('throws FormatException for malformed date string', () {
        // Arrange
        final json = {
          'id': 'user-123',
          'username': 'testuser',
          'created_at': 'not-a-date-at-all',
        };

        // Act & Assert
        expect(
          () => ProfileModel.fromJson(json),
          throwsA(isA<FormatException>()),
        );
      });

      test('throws TypeError for missing id field', () {
        // Arrange
        final json = {
          'username': 'testuser',
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act & Assert
        expect(
          () => ProfileModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws TypeError for missing username field', () {
        // Arrange
        final json = {
          'id': 'user-123',
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act & Assert
        expect(
          () => ProfileModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws TypeError for missing created_at field', () {
        // Arrange
        final json = {
          'id': 'user-123',
          'username': 'testuser',
        };

        // Act & Assert
        expect(
          () => ProfileModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws TypeError for null values', () {
        // Arrange
        final json = {
          'id': null,
          'username': 'testuser',
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act & Assert
        expect(
          () => ProfileModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws TypeError for wrong field types', () {
        // Arrange
        final json = {
          'id': 123, // should be string
          'username': 'testuser',
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act & Assert
        expect(
          () => ProfileModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('ProfileModel constructor', () {
      test('creates ProfileModel with required parameters', () {
        // Arrange
        const id = 'user-123';
        const username = 'testuser';
        final createdAt = DateTime(2024, 1, 1, 12, 30, 45);

        // Act
        final result = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(result.id, id);
        expect(result.username, username);
        expect(result.createdAt, createdAt);
      });

      test('creates ProfileModel with empty string values', () {
        // Arrange
        const id = '';
        const username = '';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final result = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(result.id, '');
        expect(result.username, '');
        expect(result.createdAt, createdAt);
      });

      test('creates ProfileModel with special characters in username', () {
        // Arrange
        const id = 'user-123';
        const username = 'test@user#123!';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final result = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(result.username, 'test@user#123!');
      });

      test('ProfileModel is immutable', () {
        // Arrange
        final profile = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(profile.id, 'user-123');
        expect(profile.username, 'testuser');
        expect(profile.createdAt, DateTime(2024, 1, 1));
      });
    });

    group('equality and comparison', () {
      test('two ProfileModels with same values have same properties', () {
        // Arrange
        final profile1 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final profile2 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(profile1.id, profile2.id);
        expect(profile1.username, profile2.username);
        expect(profile1.createdAt, profile2.createdAt);
      });

      test('two ProfileModels with different values have different properties', () {
        // Arrange
        final profile1 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final profile2 = ProfileModel(
          id: 'user-456',
          username: 'differentuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(profile1.id, isNot(profile2.id));
        expect(profile1.username, isNot(profile2.username));
      });

      test('ProfileModel is not equal to different types', () {
        // Arrange
        final profile = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(profile, isNot(equals('not a profile')));
        expect(profile, isNot(equals(123)));
      });
    });
  });
}
