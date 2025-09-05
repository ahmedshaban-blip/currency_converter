# Currency Converter Application 
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/ahmedshaban-blip/currency_converter)

A simple and efficient cross-platform currency converter application built with Flutter. It allows users to convert amounts between various currencies using real-time exchange rates.

## Features

-   **Real-time Conversion**: Fetches the latest exchange rates from [ExchangeRate-API](https://www.exchangerate-api.com/).
-   **Dynamic Currency List**: Populates currency options dynamically from the API.
-   **Simple UI**: An intuitive interface for entering amounts and selecting currencies.
-   **Swap Currencies**: Easily swap the 'from' and 'to' currencies with a single tap.
-   **State Management**: Utilizes Flutter Bloc (Cubit) for robust and predictable state management.
-   **Cross-Platform**: Designed to run on Android, iOS, Web, Windows, macOS, and Linux from a single codebase.

## Tech Stack

-   **Framework**: Flutter
-   **State Management**: `flutter_bloc` / `cubit`
-   **HTTP Client**: `http` package
-   **Forms & Validation**: `flutter_form_builder`, `form_builder_validators`
-   **API**: `exchangerate-api.com`

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

-   Ensure you have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
-   An IDE like Visual Studio Code or Android Studio with the Flutter plugin.

### Installation & Running

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/ahmedshaban-blip/currency_converter.git
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd currency_converter
    ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the application:**
    ```sh
    flutter run
    ```
    You can select your target device (e.g., emulator, physical device, or web browser).

## Project Structure

The project follows a standard Flutter structure. Key files include:

-   `lib/main.dart`: The entry point for the application.
-   `lib/convertscreen.dart`: The main screen widget containing the UI for the currency converter.
-   `lib/Api/apiConvert.dart`: Handles the API call to fetch exchange rates.
-   `lib/cubit/`: Contains the logic for state management.
    -   `currency_converter_cubit.dart`: The Cubit class that manages the application's state.
    -   `currency_converter_state.dart`: Defines the states for the currency converter.
