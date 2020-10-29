import 'package:Minimal_Weather/services/location.dart';
import 'package:Minimal_Weather/services/networking.dart';
import 'package:Minimal_Weather/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper('$url?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$url?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  // ignore: missing_return
  IconData getWeatherIcon(int condition, String dt) {
    switch (condition) {
      case 200:
        return WeatherIcons.thunderstorm;
        break;
      case 201:
        return WeatherIcons.thunderstorm;
        break;

      case 202:
        return WeatherIcons.thunderstorm;
        break;
      case 210:
        return WeatherIcons.thunderstorm;
        break;
      case 211:
        return WeatherIcons.thunderstorm;
        break;
      case 212:
        return WeatherIcons.thunderstorm;
        break;
      case 221:
        return WeatherIcons.thunderstorm;
        break;
      case 230:
        return WeatherIcons.storm_showers;
        break;
      case 231:
        return WeatherIcons.storm_showers;
        break;
      case 232:
        return WeatherIcons.lightning;
        break;
      case 300:
        return WeatherIcons.raindrop;
        break;
      case 301:
        return WeatherIcons.alien;
        break;
      case 302:
        return WeatherIcons.raindrops;
        break;
      case 310:
        return WeatherIcons.rain;
        break;
      case 311:
        return WeatherIcons.hail;
        break;
      case 312:
        return WeatherIcons.hail;
        break;
      case 313:
        return WeatherIcons.storm_showers;
        break;
      case 314:
        return WeatherIcons.showers;
        break;
      case 321:
        return WeatherIcons.alien;
        break;
      case 500:
        return WeatherIcons.sprinkle;
        break;
      case 501:
        return WeatherIcons.hail;
        break;
      case 502:
        return WeatherIcons.rain;
        break;
      case 503:
        return WeatherIcons.day_rain_wind;
        break;
      case 504:
        return WeatherIcons.raindrops;
        break;
      case 511:
        return WeatherIcons.snowflake_cold;
        break;
      case 520:
        return WeatherIcons.night_alt_sprinkle;
        break;
      case 521:
        return WeatherIcons.night_alt_hail;
        break;
      case 522:
        return WeatherIcons.night_alt_rain;
        break;
      case 531:
        return WeatherIcons.night_rain;
        break;
      case 600:
        return WeatherIcons.snowflake_cold;
        break;
      case 601:
        return WeatherIcons.snow;
        break;
      case 602:
        return WeatherIcons.snow_wind;
        break;
      case 611:
        return WeatherIcons.sleet;
        break;
      case 612:
        return WeatherIcons.sleet;
        break;
      case 613:
        return WeatherIcons.sleet;
        break;
      case 615:
        return WeatherIcons.rain_mix;
        break;
      case 616:
        return WeatherIcons.rain_wind;
        break;
      case 620:
        return WeatherIcons.showers;
        break;
      case 621:
        return WeatherIcons.snow;
        break;
      case 622:
        return WeatherIcons.snow_wind;
        break;
      case 701:
        return WeatherIcons.fog;
        break;
      case 711:
        return WeatherIcons.smoke;
        break;
      case 721:
        return WeatherIcons.day_haze;
        break;
      case 731:
        return WeatherIcons.strong_wind;
        break;
      case 741:
        return WeatherIcons.fog;
        break;
      case 751:
        return WeatherIcons.sandstorm;
        break;
      case 761:
        return WeatherIcons.dust;
        break;
      case 762:
        return WeatherIcons.volcano;
        break;
      case 771:
        return WeatherIcons.cloudy_gusts;
        break;
      case 781:
        return WeatherIcons.tornado;
        break;
      case 800:
        if (dt == '01d') {
          return WeatherIcons.day_sunny;
        } else if (dt == '01n') {
          return WeatherIcons.night_clear;
        }
        break;
      case 801:
        if (dt == '02d') {
          return WeatherIcons.day_cloudy;
        } else if (dt == '02n') {
          return WeatherIcons.night_alt_cloudy;
        }
        break;
      case 802:
        return WeatherIcons.cloud;
        break;
      case 803:
        return WeatherIcons.cloudy;
        break;
      case 804:
        return WeatherIcons.cloudy;
        break;
      default:
        return WeatherIcons.alien;
    }
  }
}
