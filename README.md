# Flutter API Testing App 🚀

This is a mobile-optimized API testing application built with Flutter. It allows you to send various types of HTTP requests, view the responses, and manage a local history of your interactions. The app is designed with a clean, Material 3-compliant UI and features one-handed usability. All data is stored locally on your device.

-----

## Features ✨

  * **HTTP Methods:** Supports `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, and `HEAD` requests.
  * **Request Customization:** Easily set the URL, headers, and request body.
  * **Authentication:** Handles `Bearer` and `Basic` token authentication.
  * **Response Viewer:** Displays the status code, duration, and response body. Includes a toggle to switch between **Raw** and **Prettified** JSON.
  * **Local History:** Saves all your requests and responses to a local SQLite database for easy access. You can replay, edit, or delete past requests.
  * **Theming:** Customizable theme with a color picker and a dark mode toggle.
  * **Mobile-First UI:** Designed for comfortable one-handed use with a bottom navigation bar.

-----

## Project Structure 📁

The project follows a standard Flutter architecture with a clear separation of concerns:

  * `lib/main.dart`: The entry point of the application, handling global state management and theme.
  * `lib/screens/`: Contains the main pages of the app (`RequestBuilder`, `HistoryPage`, `SettingsPage`).
  * `lib/widgets/`: Reusable UI components (e.g., `MethodDropdown`, `HeaderList`).
  * `lib/services/`: Business logic for API calls (`ApiService`) and local database operations (`DbService`).
  * `lib/models/`: Data models for requests, responses, and environments.

-----

## Dependencies 📦

  * `http`: A composable, future-based library for making HTTP requests.
  * `sqflite`: A plugin for SQLite database access.
  * `path_provider`: Finds the correct platform-specific paths for storing data.
  * `provider`: A simple, yet powerful, state management solution.
  * `flutter_material_color_picker`: A widget to pick a color from the Material Design color palette.
  * `flutter_secure_storage`: A secure storage solution for sensitive data like tokens.
  * `oauth2`: A library for handling OAuth 2.0 authorization flows.

-----

## Getting Started 🏃‍♂️

### Prerequisites

  * Flutter SDK installed.
  * An IDE (e.g., VS Code or Android Studio) with Flutter and Dart plugins.

### Installation

1.  Clone the repository:
    ```sh
    git clone https://github.com/your-username/flutter-api-tester.git
    ```
2.  Navigate to the project directory:
    ```sh
    cd flutter-api-tester
    ```
3.  Install the dependencies:
    ```sh
    flutter pub get
    ```
4.  Run the app on a connected device or emulator:
    ```sh
    flutter run
    ```

-----

## Test Server 🧪

A simple Node.js server is included in the `./server` directory to help you test the app's functionality. This server is set up to respond to various HTTP requests.

### Usage

1.  Navigate to the server directory:
    ```sh
    cd server
    ```
2.  Install the Node.js dependencies:
    ```sh
    npm install
    ```
3.  Start the server:
    ```sh
    node test_server.js
    ```

The server will run on `http://localhost:3000`. You can now use this URL in the app to test different methods and responses.

-----

## License 📄

This project is licensed under the **MIT License**.

Copyright (c) [2025] [Agam Airi]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.