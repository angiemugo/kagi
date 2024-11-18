# **Kagi Task - Take-Home Test**

This project was developed as part of a take-home test to showcase expertise in **Flutter development**, **app architecture**, and **UI design**. The app loads news data from a JSON file, categorizes it, and presents it in an interactive and user-friendly interface.

---

## **Features**
- **Tabbed News View**: Organizes news by category in a tabbed interface for easy navigation.
- **Drawer Navigation**: Provides additional sections for general settings and advanced options.
- **Detailed News View**: Offers detailed views for individual news items, including:
  - **Highlights** as bullet points.
  - **Embedded web view** to read full articles.
  - **Timeline and perspectives** for context.
  - **Image gallery** with location overlays.
- **Localization**: Supports multiple languages with dynamic string localization.
- **Error Handling**: Displays user-friendly error messages for data-related issues.

---

## **Objective**
The goal of this take-home test was to:
1. **Demonstrate clean architecture** with a focus on scalability.
2. **Implement MVVM architecture** for separation of concerns.
3. **Showcase state management** with **Riverpod**.
4. **Design a responsive Flutter UI**.
5. Highlight expertise in **JSON parsing** and **asynchronous programming**.

---

## **App Architecture**
The app uses the **MVVM (Model-View-ViewModel)** architecture to maintain separation of concerns, making it scalable and testable.

### Layers:
1. **Model**: Represents the core business data (`NewsModel`, `Cluster`, etc.).
2. **ViewModel (Controller)**: Manages state and business logic using **Riverpod**.
3. **View**: Contains screens and widgets responsible for rendering the UI.

---

## **Technologies Used**
- **Flutter**: For cross-platform app development.
- **Riverpod**: For state management and reactive updates.
- **Dart**: Programming language.
- **Share Plus**: For sharing article links.
- **WebView**: To load external article content.
- **Intl**: For date formatting and localization.

---

## **Setup and Installation**

### Prerequisites
- Ensure [Flutter](https://docs.flutter.dev/get-started/install) is installed and configured.
- **Flutter version**: The app was developed and tested using **Flutter 3.24.3**.

### Steps to Run the Project
1. Clone the repository:
   ```bash
   git clone https://github.com/angiemugo/kagi.git
   ```
2. Navigate to the project directory:
   ```bash
   cd kagi
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Generate code:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
5. Generate localization files:
   ```bash
   flutter gen-l10n
   ```
6. Run the app:
   ```bash
   flutter run
   ```

---

## **Project Structure**

```
lib/
├── newsDetail/
│   ├── presentation/       # UI components for the News Detail feature
│   │   └── news_detail_screen.dart
│   ├── widgets/            # Reusable widgets for the News Detail feature
│       ├── bullet_points_view.dart
│       ├── image_view.dart
│       ├── perspective_view.dart
│       ├── timeline_section.dart
│       └── webview.dart
│
├── service/                # Shared services and utilities
│   └── json_reader.dart
│
├── tabbedView/
│   ├── data/               # Data sources and repositories
│   │   └── articles_repository.dart
│   ├── domain/             # Core business models
│   │   └── news_model.dart
│   ├── presentation/       # UI components for the Tabbed View feature
│       └── tabbed_news_screen.dart
│
├── util/                   # Shared utilities
│   ├── kite_theme.dart     # Theme and styling
│   └── app_localizations.dart # Localization setup
```

---

## **Demo**
> Include screenshots or a video link showcasing the app's features.

<div style="display: flex; flex-wrap: nowrap; gap: 10px;">
  <img src="https://github.com/user-attachments/assets/345595a6-ee6c-479d-b90a-50dd9735ab25" alt="Screenshot 1" width="200">
  <img src="https://github.com/user-attachments/assets/0b4d212e-f78a-43fd-a2ff-d5aaf569b862" alt="Screenshot 2" width="200">
  <img src="https://github.com/user-attachments/assets/6680a763-7c8c-4e70-98e1-9dae0098e5ce" alt="Screenshot 3" width="200">
  <img src="https://github.com/user-attachments/assets/290870b2-8613-4d66-b58b-13909dd74a6e" alt="Screenshot 4" width="200">
</div>

---

## **Challenges Addressed**
- **JSON Parsing**: Efficiently reading and decoding data from a JSON file.
- **State Management**: Using **Riverpod** to manage application state across multiple features.
- **Scalability**: Following **clean architecture** principles to ensure future maintainability.
- **UI Responsiveness**: Creating a smooth, responsive, and visually appealing design.

---

## **Future Enhancements**
The app was designed for demonstration purposes. Potential extensions include:
- Linking the extra options to actual actions 
- Integrating a live API for real-time news updates.
- Adding persistent user preferences.
- Implementing unit and widget tests for improved reliability.

--- 
