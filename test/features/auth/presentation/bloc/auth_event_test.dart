import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  test('AuthLogin constructs with named params and exposes fields', () {
    final event = AuthLogin(email: 'user@example.com', password: 'secret');

    expect(event.email, 'user@example.com');
    expect(event.password, 'secret');
  });

  test('AuthLogin uses empty props from base AuthEvent', () {
    final event = AuthLogin(email: 'a@b.c', password: 'pw');

    expect(event.props, isEmpty);
  });
}


