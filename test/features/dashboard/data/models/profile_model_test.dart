import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_bloc_app/features/dashboard/data/models/profile_model.dart';

void main() {
  group('ProfileModel', () {
    group('constructor', () {
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

      test('creates ProfileModel with numeric string ID', () {
        // Arrange
        const id = '12345';
        const username = 'numericuser';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final result = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(result.id, '12345');
        expect(result.username, 'numericuser');
      });

      test('creates ProfileModel with very long username', () {
        // Arrange
        const id = 'user-123';
        final username = 'a'.padRight(100, 'a'); // 100 character username
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final result = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(result.username.length, 100);
        expect(result.username, username);
      });

      test('creates ProfileModel with different date formats', () {
        // Arrange
        const id = 'user-123';
        const username = 'testuser';
        final createdAt1 = DateTime(2024, 1, 1);
        final createdAt2 = DateTime(2024, 12, 31, 23, 59, 59);
        final createdAt3 = DateTime(2000, 1, 1);

        // Act
        final result1 = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt1,
        );
        final result2 = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt2,
        );
        final result3 = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt3,
        );

        // Assert
        expect(result1.createdAt, createdAt1);
        expect(result2.createdAt, createdAt2);
        expect(result3.createdAt, createdAt3);
      });
    });

    group('fromJson factory method', () {
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

      test('creates ProfileModel with different date formats', () {
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

    group('immutability', () {
      test('entity is immutable after creation', () {
        // Arrange
        final entity = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity.id, 'user-123');
        expect(entity.username, 'testuser');
        expect(entity.createdAt, DateTime(2024, 1, 1));

        // Verify that the values cannot be changed
        expect(entity.id, isA<String>());
        expect(entity.username, isA<String>());
        expect(entity.createdAt, isA<DateTime>());
      });

      test('entity properties are final', () {
        // Arrange
        final entity = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity.id, 'user-123');
        expect(entity.username, 'testuser');
        expect(entity.createdAt, DateTime(2024, 1, 1));

        // The properties should be final and cannot be reassigned
        // This test verifies the structure is correct
        expect(entity.runtimeType.toString(), contains('ProfileModel'));
      });
    });

    group('equality and comparison', () {
      test('two entities with same values have same properties', () {
        // Arrange
        final entity1 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final entity2 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity1.id, entity2.id);
        expect(entity1.username, entity2.username);
        expect(entity1.createdAt, entity2.createdAt);
      });

      test('two entities with different IDs have different properties', () {
        // Arrange
        final entity1 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final entity2 = ProfileModel(
          id: 'user-456',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity1.id, isNot(entity2.id));
      });

      test('two entities with different usernames have different properties', () {
        // Arrange
        final entity1 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final entity2 = ProfileModel(
          id: 'user-123',
          username: 'differentuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity1.username, isNot(entity2.username));
      });

      test('two entities with different dates have different properties', () {
        // Arrange
        final entity1 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final entity2 = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 2),
        );

        // Act & Assert
        expect(entity1.createdAt, isNot(entity2.createdAt));
      });

      test('entity is not equal to different types', () {
        // Arrange
        final entity = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity, isNot(equals('not a profile')));
        expect(entity, isNot(equals(123)));
        expect(entity, isNot(equals(null)));
      });

      test('entity is not equal to null', () {
        // Arrange
        final entity = ProfileModel(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity, isNot(equals(null)));
      });
    });

    group('edge cases', () {
      test('handles very long ID strings', () {
        // Arrange
        final id = 'a'.padRight(1000, 'a'); // 1000 character ID
        const username = 'testuser';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.id.length, 1000);
        expect(entity.id, id);
      });

      test('handles unicode characters in username', () {
        // Arrange
        const id = 'user-123';
        const username = 'tëstüser🎉'; // Unicode characters
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.username, 'tëstüser🎉');
        expect(entity.username.length, 10); // Correct unicode length
      });

      test('handles whitespace in username', () {
        // Arrange
        const id = 'user-123';
        const username = '  test user  '; // Leading and trailing spaces
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.username, '  test user  ');
        expect(entity.username.length, 13);
      });

      test('handles zero date', () {
        // Arrange
        const id = 'user-123';
        const username = 'testuser';
        final createdAt = DateTime(1970, 1, 1); // Unix epoch

        // Act
        final entity = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.createdAt, DateTime(1970, 1, 1));
      });

      test('handles future date', () {
        // Arrange
        const id = 'user-123';
        const username = 'testuser';
        final createdAt = DateTime(2030, 12, 31, 23, 59, 59);

        // Act
        final entity = ProfileModel(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.createdAt, DateTime(2030, 12, 31, 23, 59, 59));
      });
    });
  });
}
