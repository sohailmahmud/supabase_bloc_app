import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_bloc_app/features/auth/domain/entities/user_entity.dart';

void main() {
  test('UserEntity holds given values', () {
    const entity = UserEntity(id: 'u1', email: 'user@example.com');

    expect(entity.id, 'u1');
    expect(entity.email, 'user@example.com');
  });
}


