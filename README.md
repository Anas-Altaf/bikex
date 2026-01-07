<p align="center">
  <img src="assets/images/logo.png" alt="BikeX Logo" width="120"/>
</p>

<h1 align="center">🚴 BikeX</h1>

<p align="center">
  <strong>Premium E-Commerce Mobile App for Bikes</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#screenshots">Screenshots</a> •
  <a href="#tech-stack">Tech Stack</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#getting-started">Getting Started</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart" alt="Dart"/>
  <img src="https://img.shields.io/badge/BLoC-Pattern-blueviolet" alt="BLoC"/>
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License"/>
</p>

---

<p align="center">
  <!-- VIDEO DEMO PLACEHOLDER -->
  <br/>
  
  <br/><br/>
</p>

---

## ✨ Features

| Feature                  | Description                                  |
| ------------------------ | -------------------------------------------- |
| 🏠 **Product Catalog**   | Browse 32+ premium bikes across 4 categories |
| 🔍 **Animated Search**   | Full-screen search with real-time filtering  |
| ❤️ **Favorites**         | Save your favorite bikes for later           |
| 🛒 **Shopping Cart**     | Add items, adjust quantities, checkout       |
| 📦 **Order Tracking**    | View order history with status badges        |
| 🎨 **Glassmorphism UI**  | Modern frosted glass effects with gradients  |
| ⚡ **Smooth Animations** | Staggered animations, transitions & gestures |
| 🌙 **Dark Theme**        | Elegant dark mode design                     |

---

## 📱 Screenshots

<p align="center">
  <img width="720" height="1520" alt="bikex" src="https://github.com/user-attachments/assets/dcf6cf91-15f1-4e57-9dc6-5cac36d5e3bc" />

</p>

---

## 🛠 Tech Stack

### Core

- **Flutter 3.x** - Cross-platform UI framework
- **Dart 3.x** - Programming language with null safety

### State Management

- **flutter_bloc** - Predictable state management with Cubit pattern
- **equatable** - Value equality for state classes

### Navigation

- **go_router** - Declarative routing with deep linking support

### UI/UX

- **animate_do** - Pre-built animations
- **flutter_svg** - SVG rendering
- **google_fonts** - Custom typography (Poppins)
- **flutter_inset_shadow** - Advanced shadow effects
- **toastification** - Beautiful toast notifications

### Development

- **very_good_cli** - Project scaffolding & best practices
- **flutter_lints** - Strict linting rules

---

## 🏗 Architecture

```
lib/
├── app/                    # App entry point & configuration
├── bikes/                  # Products feature module
│   ├── cubit/              # Product & favorites state
│   ├── models/             # Product model
│   ├── repo/               # Repository abstraction
│   ├── view/               # Pages (catalog, detail)
│   └── widgets/            # Product cards, hero, search
├── cart/                   # Shopping cart feature
│   ├── cubit/              # Cart state management
│   ├── models/             # Cart item model
│   └── widgets/            # Cart cards, summary
├── checkout/               # Checkout flow
│   ├── cubit/              # Checkout state
│   ├── models/             # Address model
│   └── widgets/            # Address card, slider
├── orders/                 # Order history
│   ├── cubit/              # Orders state
│   ├── models/             # Order model
│   └── widgets/            # Order cards
├── core/                   # Shared utilities
│   ├── theme/              # Colors, gradients, blur
│   ├── widgets/            # Reusable components
│   └── constants.dart      # Magic numbers
├── navigation/             # Bottom tab navigation
├── routes/                 # GoRouter configuration
└── l10n/                   # Localization
```

### Design Principles

- **BLoC Pattern** - Separation of UI and business logic
- **Repository Pattern** - Abstracted data sources
- **Feature-first** - Modular, scalable folder structure
- **Immutable State** - Predictable state updates with Equatable

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code
- Android Emulator or iOS Simulator

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Anas-Altaf/bikex.git
   cd bikex
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   # Development
   flutter run --flavor development --target lib/main_development.dart

   # Production
   flutter run --flavor production --target lib/main_production.dart
   ```

### Build

```bash
# Android APK
flutter build apk --flavor production --target lib/main_production.dart

# Android App Bundle
flutter build appbundle --flavor production --target lib/main_production.dart

# iOS
flutter build ios --flavor production --target lib/main_production.dart
```

---

## 📂 Product Categories

| Category    | Products | Price Range   |
| ----------- | -------- | ------------- |
| ⚡ Electric | 8 bikes  | $999 - $3,299 |
| 🏎 Road      | 8 bikes  | $899 - $2,199 |
| ⛰ Mountain  | 8 bikes  | $799 - $1,899 |
| 🏙 Urban     | 8 bikes  | $349 - $899   |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/Anas-Altaf">Anas Altaf</a>
</p>
