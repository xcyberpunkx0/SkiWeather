# Weather App

A simple and intuitive weather application built using Flutter that fetches real-time weather data using the OpenWeather API. This app provides current weather conditions, forecasts, and additional details like temperature, humidity, and wind speed for any location worldwide.

## Features

- **Real-time Weather Data**: Fetches current weather data from OpenWeather API.
- **Search by City**: Allows users to search for weather details by entering the city name.
- **Weather Forecast**: Provides current weather conditions as well as a 5-day forecast.
- **User-friendly UI**: Simple and attractive interface that works on both Android and iOS.
- **Location-based Weather**: Option to get weather information based on your current location.
- **Dynamic Weather Icons**: Displays weather icons and updates based on the weather conditions (sunny, rainy, cloudy, etc.).

## Installation

To run this project locally, follow these steps:

### Prerequisites

- **Flutter SDK**: You need to have the Flutter SDK installed. [Install Flutter](https://flutter.dev/docs/get-started/install)
- **OpenWeather API Key**: Sign up at [OpenWeather](https://openweathermap.org/api) to get your API key.

### Steps

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/weather-app.git
   cd weather-app

2. **Install dependencies**:

In the project root directory, run:

bash
Copy code
flutter pub get

3. **Add your API key**:

Open lib/constants.dart (or wherever you store constants) and add your OpenWeather API key:

dart
Copied!
const String apiKey = 'YOUR_API_KEY';

4. **Run the app**:

For Android:

bash
Copy code
flutter run
For iOS, ensure you have Xcode installed and run:

bash
Copy code
flutter run

Dependencies
The app uses the following dependencies:

http: For making network requests to fetch weather data.
geolocator: For accessing the user’s location.
flutter_bloc: State management using BLoC pattern.
intl: For formatting dates and numbers.
weather_icons: For displaying weather icons.
You can find all the dependencies listed in the pubspec.yaml file.

Contributing
Feel free to contribute to this project! Please fork the repository and create a pull request if you'd like to add features, fix bugs, or improve the app.

Fork the project
Create your feature branch (git checkout -b feature/YourFeature)
Commit your changes (git commit -m 'Add YourFeature')
Push to the branch (git push origin feature/YourFeature)
Open a Pull Request
License
This project is licensed under the MIT License - see the LICENSE file for details.

