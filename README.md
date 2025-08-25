# Supabase BLoC App 🚀

Flutter app with:
- Supabase (Auth + Database)
- Firebase Cloud Messaging (Push Notifications)
- BLoC State Management
- Clean Architecture

## Features
✅ User Auth (Supabase)  
✅ Dashboard with Profile Fetch  
✅ Push Notifications (notify all via FCM topic)  
✅ Scalable Clean Architecture  

## Setup
1. Clone the repo:
   ```bash
   git clone https://github.com/<your-username>/supabase_bloc_app.git

2. Install dependencies:
   ```bash
   flutter pub get

3. Setup Firebase:
    - Add google-services.json in android/app/
    - Add GoogleService-Info.plist in ios/Runner/

4. Setup Supabase:
    - Add your SUPABASE_URL + ANON_KEY in main.dart
    - Create profiles table with id, username, created_at, fcm_token

5. Run app:
   ```bash
   flutter run


🏗 Clean Architecture Structure

lib/
  core/
    error/
    usecases/
    utils/
  features/
    auth/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        bloc/
        pages/
    dashboard/
      data/
      domain/
      presentation/
    notifications/
      data/
      domain/
      presentation/
  app.dart
  main.dart

#### 🔑 Layer Responsibilities
1. Domain (Business Rules)
- Entities (pure Dart models)
- Abstract repositories
- Use cases

2. Data (Data Access)
- Supabase datasource
- DTOs (models for JSON mapping)
- Repository implementation

3. Presentation (UI Layer)
- Pages (Flutter Widgets)
- Bloc/Cubit for state management
- Consumes domain use cases