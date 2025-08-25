import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'features/dashboard/domain/usecases/get_profile_usecase.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/notifications/data/datasources/notification_remote_datasource.dart';
import 'features/notifications/data/repositories/notification_repository_impl.dart';
import 'features/notifications/domain/usecases/get_device_token_usecase.dart';
import 'features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://YOUR_PROJECT.supabase.co",
    anonKey: "YOUR_SUPABASE_ANON_KEY",
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final supabase = Supabase.instance.client;

  // Data sources
  final authDS = AuthRemoteDataSourceImpl(supabase);
  final dashboardDS = DashboardRemoteDataSourceImpl(supabase);
  final notificationDS = NotificationRemoteDataSourceImpl(FirebaseMessaging.instance);

  // Repositories
  final authRepo = AuthRepositoryImpl(authDS);
  final dashboardRepo = DashboardRepositoryImpl(dashboardDS);
  final notificationRepo = NotificationRepositoryImpl(notificationDS);

  // Use cases
  final getProfileUseCase = GetProfileUseCase(dashboardRepo);
  final getDeviceTokenUseCase = GetDeviceTokenUseCase(notificationRepo);
  final subscribeUseCase = SubscribeToTopicUseCase(notificationRepo);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepository: authRepo)),
        BlocProvider(create: (_) => DashboardBloc(getProfileUseCase)),
        BlocProvider(create: (_) =>
            NotificationBloc(getDeviceTokenUseCase, subscribeUseCase)
              ..add(NotificationInit())
              ..add(NotificationSubscribe("all")) // auto-subscribe
        ),
      ],
      child: const MyApp(),
    ),
  );
}
