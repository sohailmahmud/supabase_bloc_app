import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase BLoC App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, dashboardState) {
                if (dashboardState is DashboardInitial) {
                  // Load profile when authenticated
                  context.read<DashboardBloc>().add(
                        DashboardLoad(state.userId),
                      );
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (dashboardState is DashboardLoading) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (dashboardState is DashboardLoaded) {
                  return DashboardPage(profile: dashboardState.profile);
                } else if (dashboardState is DashboardError) {
                  return Scaffold(
                    body: Center(child: Text(dashboardState.message)),
                  );
                }
                return const SizedBox();
              },
            );
          } else if (state is AuthLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}