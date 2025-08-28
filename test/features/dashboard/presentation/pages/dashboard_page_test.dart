import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/entities/profile_entity.dart';
import 'package:supabase_bloc_app/features/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  group('DashboardPage', () {
    group('UI Rendering', () {
      testWidgets('renders dashboard with profile information', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1, 12, 30, 45),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('Dashboard'), findsOneWidget);
        expect(find.text('👋 Welcome, testuser'), findsOneWidget);
        expect(find.text('User ID: user-123'), findsOneWidget);
        expect(find.text('Joined: ${profile.createdAt.toLocal()}'), findsOneWidget);
      });

      testWidgets('renders dashboard with different profile data', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-456',
          username: 'differentuser',
          createdAt: DateTime(2024, 2, 1, 15, 45, 30),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('👋 Welcome, differentuser'), findsOneWidget);
        expect(find.text('User ID: user-456'), findsOneWidget);
        expect(find.text('Joined: ${profile.createdAt.toLocal()}'), findsOneWidget);
      });

      testWidgets('renders dashboard with empty username', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: '',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('👋 Welcome, '), findsOneWidget);
        expect(find.text('User ID: user-123'), findsOneWidget);
      });

      testWidgets('renders dashboard with special characters in username', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'test@user#123!',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('👋 Welcome, test@user#123!'), findsOneWidget);
        expect(find.text('User ID: user-123'), findsOneWidget);
      });

      testWidgets('renders dashboard with very long username', (tester) async {
        // Arrange
        final longUsername = 'a'.padRight(100, 'a'); // 100 character username
        final profile = ProfileEntity(
          id: 'user-123',
          username: longUsername,
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('👋 Welcome, $longUsername'), findsOneWidget);
        expect(find.text('User ID: user-123'), findsOneWidget);
      });

      testWidgets('renders dashboard with numeric user ID', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: '12345',
          username: 'numericuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('👋 Welcome, numericuser'), findsOneWidget);
        expect(find.text('User ID: 12345'), findsOneWidget);
      });

      testWidgets('renders dashboard with very long user ID', (tester) async {
        // Arrange
        final longId = 'a'.padRight(1000, 'a'); // 1000 character ID
        final profile = ProfileEntity(
          id: longId,
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('👋 Welcome, testuser'), findsOneWidget);
        expect(find.text('User ID: $longId'), findsOneWidget);
      });

      testWidgets('renders dashboard with unicode characters in username', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'tëstüser🎉',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('👋 Welcome, tëstüser🎉'), findsOneWidget);
        expect(find.text('User ID: user-123'), findsOneWidget);
      });

      testWidgets('renders dashboard with whitespace in username', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: '  test user  ',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.text('👋 Welcome,   test user  '), findsOneWidget);
        expect(find.text('User ID: user-123'), findsOneWidget);
      });
    });

    group('Layout and Styling', () {
      testWidgets('has correct app bar title', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Dashboard'), findsOneWidget);
      });

      testWidgets('has correct padding around content', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        // Find the Padding widget that wraps the main content (not the MaterialApp's internal padding)
        final paddingWidgets = find.byType(Padding);
        expect(paddingWidgets, findsAtLeastNWidgets(1));
        
        // Check that at least one Padding widget has the expected 16.0 padding
        bool foundCorrectPadding = false;
        for (final widget in paddingWidgets.evaluate()) {
          final padding = widget.widget as Padding;
          if (padding.padding == const EdgeInsets.all(16.0)) {
            foundCorrectPadding = true;
            break;
          }
        }
        expect(foundCorrectPadding, isTrue);
      });

      testWidgets('has correct column layout', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.byType(Column), findsOneWidget);
        final columnWidget = tester.widget<Column>(find.byType(Column));
        expect(columnWidget.crossAxisAlignment, CrossAxisAlignment.start);
      });

      testWidgets('has correct spacing between elements', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.byType(SizedBox), findsOneWidget);
        final sizedBoxWidget = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBoxWidget.height, 16.0);
      });

      testWidgets('uses correct text styles', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        final welcomeText = find.text('👋 Welcome, testuser');
        expect(welcomeText, findsOneWidget);
        
        // Verify the welcome text uses headlineSmall style
        final welcomeTextWidget = tester.widget<Text>(welcomeText);
        expect(welcomeTextWidget.style, isNotNull);
      });
    });

    group('Date Formatting', () {
      testWidgets('displays date in local timezone', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1, 12, 0, 0, 0, 0), // UTC
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        final expectedLocalTime = profile.createdAt.toLocal().toString();
        expect(find.text('Joined: $expectedLocalTime'), findsOneWidget);
      });

      testWidgets('displays different date formats correctly', (tester) async {
        // Arrange
        final profile1 = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );
        final profile2 = ProfileEntity(
          id: 'user-456',
          username: 'testuser2',
          createdAt: DateTime(2024, 12, 31, 23, 59, 59),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile1),
          ),
        );

        // Assert
        expect(find.text('Joined: ${profile1.createdAt.toLocal()}'), findsOneWidget);

        // Test with different profile
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile2),
          ),
        );

        expect(find.text('Joined: ${profile2.createdAt.toLocal()}'), findsOneWidget);
      });
    });

    group('Widget Structure', () {
      testWidgets('has correct widget hierarchy', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(Padding), findsAtLeastNWidgets(1));
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(Text), findsNWidgets(4)); // Welcome, User ID, Joined, and AppBar title
        expect(find.byType(SizedBox), findsOneWidget);
      });

      testWidgets('has correct number of text widgets', (tester) async {
        // Arrange
        final profile = ProfileEntity(
          id: 'user-123',
          username: 'testuser',
          createdAt: DateTime(2024, 1, 1),
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(profile: profile),
          ),
        );

        // Assert
        // Should have 4 text widgets: Welcome message, User ID, Joined date, and AppBar title
        expect(find.byType(Text), findsNWidgets(4));
      });
    });
  });
}
