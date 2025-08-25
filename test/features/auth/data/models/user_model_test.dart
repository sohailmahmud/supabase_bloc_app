import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_bloc_app/features/auth/data/models/user_model.dart';

void main() {
  test('fromSupabase creates UserModel correctly', () {
    final json = {
      'id': 'u1',
      'email': 'user@example.com',
    };

    final model = UserModel.fromSupabase(json);

    expect(model.id, 'u1');
    expect(model.email, 'user@example.com');
  });
}


