import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_model.dart';

abstract class DashboardRemoteDataSource {
  Future<ProfileModel?> getProfile(String userId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final SupabaseClient client;

  DashboardRemoteDataSourceImpl(this.client);

  @override
  Future<ProfileModel?> getProfile(String userId) async {
    final data = await client
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();
    if (data == null) return null;
    return ProfileModel.fromJson(data);
  }
}
