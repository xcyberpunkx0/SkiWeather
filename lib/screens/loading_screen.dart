import 'locations_screen.dart';
import 'package:Minimal_Weather/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen1(
            locationweather: weatherData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft, //00xfff282627
              //[Color(0xfff282627), Colors.black]
              colors: [Color(0xfff282627), Colors.black],
              // colors: [Color(0xFFFe721a2), Colors.cyan],
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitDualRing(
                lineWidth: 1,
                color: Colors.white,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Just a moment 🌦',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
