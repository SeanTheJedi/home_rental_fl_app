# Home Rental Application

A modern and feature-rich Flutter application designed to streamline the process of finding, viewing, and renting homes. This project leverages best practices in Flutter development, including state management with BLoC, modular architecture, and responsive UI design.

## 🚀 Key Features

- **Onboarding Experience**: A smooth introduction for new users to understand the app's value proposition.
- **Authentication**: Secure login and registration flows.
- **Smart Search & Filters**: Easily find homes based on location, price, and amenities.
- **Map Integration**: Visualize property locations using Google Maps.
- **Detailed Property Views**: High-quality image carousels, detailed descriptions, and amenity lists.
- **Responsive Design**: Optimized for various screen sizes using `flutter_screenutil`.
- **Local Persistence**: Remembers user preferences and "first-time" status using `shared_preferences`.

## 🛠️ Tech Stack & Dependencies

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) for predictable state transitions.
- **Navigation**: [go_router](https://pub.dev/packages/go_router) for declarative routing.
- **Typography**: [google_fonts](https://pub.dev/packages/google_fonts) for beautiful text styling.
- **Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences) for local key-value storage.
- **Maps**: [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) for interactive maps.
- **UI Components**: 
  - `carousel_slider` for image galleries.
  - `cached_network_image` for efficient image loading.
  - `shimmer` for loading states.
  - `flutter_screenutil` for screen responsiveness.
- **Utilities**: `flutter_dotenv` for environment variable management.

## 📂 Project Structure

The project follows a modular and organized folder structure:

```
lib/
├── core/               # Shared logic, constants, and utilities
│   ├── common/         # Global widgets and components
│   ├── constants/      # App-wide constants (colors, strings, etc.)
│   ├── router/         # GoRouter configuration
│   ├── services/       # External service integrations (Storage, API)
│   ├── theme/          # App theme and styling
│   └── utils/          # Helper functions and extensions
├── views/              # UI layer (Screens and view-specific widgets)
│   ├── auth/           # Login, Register screens
│   ├── onboarding/     # Onboarding flow
│   └── splash/         # Animated splash screen
├── models/             # Data models and entities
├── controllers/        # Business logic (BLoCs/Cubit)
└── main.dart           # Entry point of the application
```

## ⚙️ Getting Started

### Prerequisites

- Flutter SDK: `^3.5.3`
- Dart SDK
- Android Studio / VS Code with Flutter extensions

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

3.  **Setup Environment Variables**:
    Create a `.env` file in the root directory and add your keys (e.g., Google Maps API key):
    ```env
    GOOGLE_MAPS_API_KEY=your_key_here
    ```

4.  **Run the application**:
    ```bash
    flutter run
    ```

## 📸 Assets

The app uses several assets located in the `assets/` directory:
- `assets/images/onboarding/`: Visuals for the onboarding flow.
- `assets/images/house/`: Placeholder and sample property images.

---


## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
