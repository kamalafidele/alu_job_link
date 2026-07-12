# Campus Bridge

A Flutter mobile app connecting ALU students seeking internship experience with student-led startups and early-stage ventures in the ALU ecosystem. Startups post opportunities; students discover, filter, and apply for them; both sides track progress in real time.

## Features
- Email/password authentication with role-based onboarding (Student or Startup)
- Startup profiles with a manual verification flag
- Opportunity posting, discovery, and category-based search
- Application submission and real-time status tracking (applied → interview → accepted/rejected)
- Real-time updates powered by Firestore snapshot listeners (no manual refresh needed)
- State management via `flutter_bloc` Cubits (`AuthCubit`, `OpportunityCubit`, `ApplicationCubit`)

## Tech Stack
- **Frontend:** Flutter (Dart)
- **State management:** flutter_bloc (Cubit)
- **Backend:** Firebase Authentication + Cloud Firestore

## Getting Started
1. Create a Firebase project and enable **Authentication → Email/Password** and **Firestore Database**.
2. Install the FlutterFire CLI: `dart pub global activate flutterfire_cli`
3. From this folder, run `flutterfire configure` to generate `lib/firebase_options.dart`.
4. `flutter pub get`
5. `flutter run` (on an emulator with Google Play, or a physical device)
6. Paste `firestore.rules` into Firebase Console → Firestore → Rules, and deploy `firestore.indexes.json` (or let Firestore's error-log links create them on first run).

## Project Structure
```
lib/
  main.dart              entry point, initializes Firebase
  app.dart                MaterialApp + AuthGate (routes by auth state)
  cubit/                  AuthCubit, OpportunityCubit, ApplicationCubit
  models/                 UserModel, OpportunityModel, ApplicationModel
  screens/
    auth/                 login_screen.dart, signup_screen.dart
    student/               student_shell.dart + Home/Explore/Applications/Profile
    startup/               startup_shell.dart + Postings/Post/Applicants/Profile
  widgets/                shared UI components
firestore.rules           security rules
firestore.indexes.json    required composite indexes
```

## Firestore Schema (summary)
- `users/{uid}` — name, email, role, verified
- `opportunities/{id}` — title, category, commitment, skills, startupId, startupName, postedAt
- `applications/{id}` — opportunityId, startupId, studentId, status, appliedAt