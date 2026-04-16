# Home Rental Application

A modern and feature-rich Flutter application designed to streamline the process of finding, viewing, and renting homes. This project leverages best practices in Flutter development, including Firebase integration, robust state management, and responsive UI design.

## 🚀 Key Features

- **Onboarding Experience**: A smooth introduction for new users to understand the app's value proposition.
- **Full-Stack Authentication**: Secure login and registration flows powered by **Firebase Auth**, with role-based access control (Tenant vs. Landlord).
- **Cloud Integration**: Real-time user profiles and data synchronization using **Cloud Firestore**.
- **Smart Search & Filters**: Easily find homes based on location, price, and amenities.
- **Map Integration**: Visualize property locations using Google Maps.
- **Detailed Property Views**: High-quality image carousels, detailed descriptions, and amenity lists.
- **Responsive Design**: Optimized for various screen sizes using `flutter_screenutil`.
- **Local Persistence**: Remembers user preferences and "first-time" status using `shared_preferences`.

## 🛠️ Tech Stack & Dependencies

- **Backend**: 
  - **Firebase Auth**: For secure user authentication.
  - **Cloud Firestore**: Real-time NoSQL database for property and user data.
  - **Firebase Storage**: For hosting property and profile images.
- **State Management**: [provider](https://pub.dev/packages/provider) for reactive state handling and dependency injection.
- **Navigation**: [go_router](https://pub.dev/packages/go_router) for declarative routing and shell-based layouts.
- **Typography**: [google_fonts](https://pub.dev/packages/google_fonts) for beautiful text styling.
- **Maps**: [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) for interactive maps.
- **UI Components**: 
  - `carousel_slider` for image galleries.
  - `cached_network_image` for efficient image loading.
  - `shimmer` for loading states.
  - `flutter_screenutil` for screen responsiveness.
- **Utilities**: `flutter_dotenv` for environment variable management, `intl` for formatting.

## 📂 Project Structure

The project follows a modular and organized folder structure:

```
lib/
├── controllers/        # Business logic & state management (Auth, etc.)
├── core/               # Shared logic, constants, and utilities
│   ├── common/         # Global widgets (Bottom Nav, Page Layouts)
│   ├── constants/      # App-wide constants (Colors, App Strings)
│   ├── router/         # GoRouter configuration
│   ├── services/       # External service integrations (Firebase, Storage)
│   ├── theme/          # Material 3 App theme and styling
│   └── utils/          # Helper functions and extensions
├── models/             # Data models and entities (User, Property, Booking)
├── views/              # UI layer (Screens and view-specific widgets)
│   ├── auth/           # Login, Register screens
│   ├── booking/        # Booking lists and details
│   ├── home/           # Main dashboard and search
│   ├── onboarding/     # Onboarding flow
│   ├── profile/        # User profile and settings (Firebase Integrated)
│   └── splash/         # Animated splash screen
└── main.dart           # Entry point with Provider & Firebase initialization
```

## ⚙️ Getting Started

### Prerequisites

- Flutter SDK: `^3.5.3`
- Firebase account and a configured project.
- Android Studio / VS Code with Flutter extensions.

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/home_rental_application.git
    cd home_rental_application
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Firebase Setup**:
    - Install FlutterFire CLI: `dart pub global activate flutterfire_cli`
    - Configure Firebase: `flutterfire configure`
    - This will generate `lib/firebase_options.dart`.

4.  **Setup Environment Variables**:
    Create a `.env` file in the root directory and add your keys:
    ```env
    GOOGLE_MAPS_API_KEY=your_key_here
    ```

5.  **Run the application**:
    ```bash
    flutter run
    ```

## ✅ Recent Updates & Fixes

- **Firebase Integration**: Connected Auth and Firestore for real-time user management.
- **Profile Redesign**: Fully dynamic profile screen with logout functionality and confirmation dialogs.
- **Responsiveness**: Resolved `LateInitializationError` by properly initializing `ScreenUtil` in the app root.
- **UI Polishing**: Enhanced TabBar styling for bookings and fixed layout overflows in cards.
- **Bug Fixes**: Corrected routing spelling mismatches and Material 3 theme type errors.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

Distributed under the MIT License.
