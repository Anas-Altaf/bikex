# BikeX - Flutter Starter Template

A production-ready Flutter starter template with **Firebase Authentication**, **go_router** navigation, and **multi-flavor** support.

## Features

- ✅ **Firebase Auth** - Email/Password authentication with streams
- ✅ **go_router** - Declarative routing with auth guards
- ✅ **BLoC Pattern** - State management with flutter_bloc
- ✅ **Multi-Flavor** - Development, Staging, Production builds
- ✅ **Cross-Platform** - Android, iOS, Web, Windows, macOS
- ✅ **Localization** - Ready for internationalization

---

## Quick Start

```bash
# Clone the repository
git clone <your-repo-url>
cd bikex

# Install dependencies
flutter pub get

# Run development build
flutter run --flavor development --target lib/main_development.dart
```

---

## Using This Template for Your Project

### Step 1: Rename the Project

1. **Update `pubspec.yaml`:**
   ```yaml
   name: your_app_name
   description: Your app description
   ```

2. **Rename package imports** (find and replace across all files):
   ```
   package:bikex → package:your_app_name
   ```

3. **Update Android package name** in:
   - `android/app/build.gradle` → `applicationId`
   - `android/app/src/*/AndroidManifest.xml`

4. **Update iOS bundle identifier** in:
   - `ios/Runner.xcodeproj/project.pbxproj`
   - Or use Xcode to change Bundle Identifier

---

### Step 2: Set Up Your Own Firebase Project

#### 2.1 Create Firebase Project

```bash
# Install Firebase CLI (if not installed)
npm install -g firebase-tools

# Login to Firebase
firebase login

# Create new project
firebase projects:create your-project-id --display-name="Your App Name"
```

#### 2.2 Enable Authentication

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Navigate to **Authentication** → **Sign-in method**
4. Enable **Email/Password**

#### 2.3 Configure FlutterFire

```bash
# Activate FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure (replace with your project ID and package names)
dart pub global run flutterfire_cli:flutterfire configure \
  --project=your-project-id \
  --platforms=android,ios,web,windows,macos \
  --android-package-name=com.yourcompany.yourapp
```

This generates:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

#### 2.4 Add Flavor-Specific Apps (Android)

If using flavors, register each package name:

```bash
# Development flavor
firebase apps:create ANDROID \
  --package-name=com.yourcompany.yourapp.dev \
  --project=your-project-id

# Staging flavor
firebase apps:create ANDROID \
  --package-name=com.yourcompany.yourapp.stg \
  --project=your-project-id

# Re-run FlutterFire to update google-services.json
dart pub global run flutterfire_cli:flutterfire configure \
  --project=your-project-id \
  --platforms=android,ios,web,windows,macos
```

---

### Step 3: Update Android Flavors

Edit `android/app/build.gradle`:

```groovy
flavorDimensions "default"
productFlavors {
    development {
        dimension "default"
        applicationIdSuffix ".dev"
        versionNameSuffix "-dev"
    }
    staging {
        dimension "default"
        applicationIdSuffix ".stg"
        versionNameSuffix "-stg"
    }
    production {
        dimension "default"
        // No suffix for production
    }
}
```

---

## Project Structure

```
lib/
├── app/                    # App entry point
│   └── view/
│       └── app.dart        # MaterialApp.router setup
├── auth/                   # Authentication feature
│   ├── cubit/              # Auth state management
│   ├── models/             # User model
│   ├── repo/               # Firebase Auth repository
│   ├── view/               # Login & Signup pages
│   └── auth.dart           # Barrel export
├── home/                   # Home feature
│   ├── view/
│   │   └── home_page.dart
│   └── home.dart
├── routes/                 # Routing configuration
│   ├── app_router.dart     # GoRouter setup
│   └── routes.dart
├── l10n/                   # Localization
├── firebase_options.dart   # Auto-generated Firebase config
├── bootstrap.dart          # App initialization
└── main_*.dart             # Flavor entry points
```

---

## Adding New Features

Follow the pattern:

```
lib/your_feature/
├── cubit/                  # State management (optional)
│   ├── feature_cubit.dart
│   └── feature_state.dart
├── models/                 # Data models (optional)
├── repo/                   # Repository (optional)
├── view/
│   └── feature_page.dart   # UI
└── your_feature.dart       # Barrel export
```

---

## Adding New Routes

1. Add route path in `lib/routes/app_router.dart`:
   ```dart
   abstract class AppRoutes {
     // ... existing routes
     static const String newFeature = '/new-feature';
   }
   ```

2. Add `GoRoute` in `_routes` getter:
   ```dart
   GoRoute(
     path: AppRoutes.newFeature,
     name: 'newFeature',
     builder: (context, state) => const NewFeaturePage(),
   ),
   ```

3. Navigate using:
   ```dart
   context.go(AppRoutes.newFeature);
   // or
   context.push(AppRoutes.newFeature);
   ```

---

## Running the App

```bash
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart

# Web (no flavors needed)
flutter run -d chrome --target lib/main_development.dart
```

---

## Building for Release

```bash
# Android APK
flutter build apk --flavor production --target lib/main_production.dart

# Android App Bundle
flutter build appbundle --flavor production --target lib/main_production.dart

# iOS
flutter build ios --flavor production --target lib/main_production.dart

# Web
flutter build web --target lib/main_production.dart
```

---

## Troubleshooting

### "No matching client found for package name"
Run FlutterFire configure again to update `google-services.json`:
```bash
dart pub global run flutterfire_cli:flutterfire configure --project=your-project-id
```

### Firebase Auth not working
Ensure Email/Password is enabled in Firebase Console → Authentication → Sign-in method.

### Package name conflicts
Make sure all flavor package names are registered in Firebase and `google-services.json` contains all of them.

---

## Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management |
| `go_router` | Navigation |
| `firebase_core` | Firebase initialization |
| `firebase_auth` | Authentication |
| `equatable` | Value equality |

---

## License

MIT License - Feel free to use this template for your projects.
