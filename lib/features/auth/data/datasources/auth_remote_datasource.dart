import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    final res = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (res.user == null) throw Exception("Login failed");
    return UserModel.fromSupabase(res.user!.toJson());
  }

  @override
  Future<void> logout() async {
    await client.auth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = client.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromSupabase(user.toJson());
  }
}
