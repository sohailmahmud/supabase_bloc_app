import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  test('AuthInitial and AuthLoading are simple states', () {
    expect(AuthInitial(), isA<AuthInitial>());
    expect(AuthLoading(), isA<AuthLoading>());
  });

  test('AuthSuccess holds userId', () {
    final state = AuthSuccess(userId: 'uid-1');
    expect(state.userId, 'uid-1');
  });

  test('AuthFailure holds message', () {
    final state = AuthFailure(message: 'oops');
    expect(state.message, 'oops');
  });
}


