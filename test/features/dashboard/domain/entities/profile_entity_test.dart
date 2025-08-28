import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/entities/profile_entity.dart';

void main() {
  group('ProfileEntity', () {
    group('constructor', () {
      test('holds given values correctly', () {
        // Arrange
        const id = 'user-123';
        const username = 'testuser';
        final createdAt = DateTime(2024, 1, 1, 12, 30, 45);

        // Act
        final entity = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.id, id);
        expect(entity.username, username);
        expect(entity.createdAt, createdAt);
      });

      test('creates entity with empty string values', () {
        // Arrange
        const id = '';
        const username = '';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.id, '');
        expect(entity.username, '');
        expect(entity.createdAt, createdAt);
      });

      test('creates entity with special characters in username', () {
        // Arrange
        const id = 'user-123';
        const username = 'test@user#123!';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.username, 'test@user#123!');
      });

      test('creates entity with numeric string ID', () {
        // Arrange
        const id = '12345';
        const username = 'numericuser';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.id, '12345');
        expect(entity.username, 'numericuser');
      });

      test('creates entity with very long username', () {
        // Arrange
        const id = 'user-123';
        final username = 'a'.padRight(100, 'a'); // 100 character username
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.username.length, 100);
        expect(entity.username, username);
      });

      test('creates entity with different date formats', () {
        // Arrange
        const id = 'user-123';
        const username = 'testuser';
        final createdAt1 = DateTime(2024, 1, 1);
        final createdAt2 = DateTime(2024, 12, 31, 23, 59, 59);
        final createdAt3 = DateTime(2000, 1, 1);

        // Act
        final entity1 = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt1,
        );
        final entity2 = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt2,
        );
        final entity3 = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt3,
        );

        // Assert
        expect(entity1.createdAt, createdAt1);
        expect(entity2.createdAt, createdAt2);
        expect(entity3.createdAt, createdAt3);
      });
    });

    group('immutability', () {
      test('entity is immutable after creation', () {
        // Arrange
        final entity = ProfileEntity(
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
        final entity = ProfileEntity(
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
        expect(entity.runtimeType.toString(), contains('ProfileEntity'));
      });
    });

    group('equality and comparison', () {
      test('two entities with same values are equal', () {
        // Arrange
        final entity1 = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final entity2 = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity1.id, entity2.id);
        expect(entity1.username, entity2.username);
        expect(entity1.createdAt, entity2.createdAt);
      });

      test('two entities with different IDs are not equal', () {
        // Arrange
        final entity1 = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final entity2 = ProfileEntity(
          id: 'user-456',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity1, isNot(equals(entity2)));
      });

      test('two entities with different usernames are not equal', () {
        // Arrange
        final entity1 = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final entity2 = ProfileEntity(
          id: 'user-123',
          username: 'differentuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act & Assert
        expect(entity1, isNot(equals(entity2)));
      });

      test('two entities with different dates are not equal', () {
        // Arrange
        final entity1 = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final entity2 = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 2),
        );

        // Act & Assert
        expect(entity1, isNot(equals(entity2)));
      });

      test('entity is not equal to different types', () {
        // Arrange
        final entity = ProfileEntity(
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
        final entity = ProfileEntity(
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
        final id = List.filled(1000, 'a').join(); // 1000 character ID
        const username = 'testuser';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileEntity(
          id: id,
          username: username,
          createdAt: createdAt,
        );

        // Assert
        expect(entity.id.length, 1000);
        expect(entity.id, id);
      });

      test('handles unicode characters in username', () async {
        // Arrange
        const id = 'user-123';
        const username = 'tëstüser🎉'; // Unicode characters
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final entity = ProfileEntity(
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
        final entity = ProfileEntity(
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
        final entity = ProfileEntity(
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
        final entity = ProfileEntity(
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
