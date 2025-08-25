import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';

class DashboardPage extends StatelessWidget {
  final ProfileEntity profile;

  const DashboardPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("👋 Welcome, ${profile.username}",
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text("User ID: ${profile.id}"),
            Text("Joined: ${profile.createdAt.toLocal()}"),
          ],
        ),
      ),
    );
  }
}
