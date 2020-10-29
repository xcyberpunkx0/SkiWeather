import 'package:Minimal_Weather/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:Minimal_Weather/services/weather.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class LocationScreen1 extends StatefulWidget {
  LocationScreen1({this.locationweather});

  final locationweather;
  @override
  _LocationScreen1 createState() => _LocationScreen1();
}

class _LocationScreen1 extends State<LocationScreen1> {
  WeatherModel weather = WeatherModel();
  // Gradients _gradients = Gradients();

  var _controller = TextEditingController();

  var newtime;
  int temperature = 0;
  String cityName = '';
  IconData weatherIcon;
  double windspeed = 0;
  int humidity = 0;
  int hr;
  double min;
  int offset;
  String time = '00:00';
  String description = '';
  // Color icongradient1;
  // Color icongradient2;
  String diff;
  var mindiff;
  IconData daynighticon;
  Color daynighticoncolor;
  Timer timer;

  @override
  void initState() {
    super.initState();
    // updateUI(widget.locationweather);

    timer = Timer.periodic(
        Duration(), (Timer t) => updateUI(widget.locationweather));
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temperature = 0;
      weatherIcon = WeatherIcons.alien;
      cityName = '';
      windspeed = 0;
      humidity = 0;
      description = '';

      return;
    }
    if (timer.isActive) {
      timer.cancel();
    }
    timer = Timer.periodic(
        Duration(seconds: 60), (Timer t) => updateUI(weatherData));

    var dt = DateTime.now().toUtc();
    var a; //sunrise
    var b; //sunset

    setState(() {
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      // var condition = 800;
      String timeofday = weatherData['weather'][0]['icon'];
      weatherIcon = weather.getWeatherIcon(condition, timeofday);
      // icongradient1 = _gradients.getGradient1(condition, timeofday);
      // icongradient2 = _gradients.getGradient2(condition, timeofday);
      humidity = weatherData['main']['humidity'];
      cityName = weatherData['name'];
      var windspeeed = weatherData['wind']['speed'];
      double num1 = double.parse((windspeeed * 3.6).toStringAsFixed(1));
      windspeed = num1;
      description = weatherData['weather'][0]['description'];
      offset = weatherData['timezone'];
      var sunrise = weatherData['sys']['sunrise'];
      var sunset = weatherData['sys']['sunset'];
      a = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000).toUtc();
      b = DateTime.fromMillisecondsSinceEpoch(sunset * 1000).toUtc();

      int thr = offset;
      thr = offset ~/ 3600;

      if (thr < 0) {
        min = ((offset.abs() / 3600) - -thr) * 60;
        a = a.subtract(
          Duration(
            hours: -thr,
            minutes: min.toInt(),
          ),
        );
        b = b.subtract(
          Duration(
            hours: -thr,
            minutes: min.toInt(),
          ),
        );

        newtime = dt.subtract(
          Duration(
            hours: -thr,
            minutes: min.toInt(),
          ),
        );
      } else {
        min = ((offset.abs() / 3600) - thr) * 60;
        b = b.add(
          Duration(
            hours: thr,
            minutes: min.toInt(),
          ),
        );
        a = a.add(
          Duration(
            hours: thr,
            minutes: min.toInt(),
          ),
        );

        newtime = dt.add(
          Duration(
            hours: thr,
            minutes: min.toInt(),
          ),
        );
      }
      print(a);
      print(b);
      print(newtime);

      if (newtime.isAfter(b) || newtime.isBefore(a)) {
        daynighticon = WeatherIcons.night_clear;
        daynighticoncolor = Color(0xFFF9FA9E1);
        if (newtime.hour >= b.hour && newtime.hour < 24) {
          //done
          a = a.add(
            Duration(days: 1),
          );
          var diff2 = a.difference(newtime);
          int hr = diff2.inHours;

          double min = diff2.inMinutes / 60 - hr;

          double diff1 = hr + min;

          diff = diff1.toStringAsFixed(1);

          if (diff2.inHours == 0) {
            double diff1 = diff2.inMinutes / 60;
            diff = diff1.toStringAsFixed(1);
          }
        } else {
          //done
          var diff2 = a.difference(newtime);
          int hr = diff2.inHours;
          print(diff2);

          double min = diff2.inMinutes / 60 - hr;

          double diff1 = hr + min;

          diff = diff1.toStringAsFixed(1);

          if (diff2.inHours == 0) {
            double diff1 = diff2.inMinutes / 60;
            diff = diff1.toStringAsFixed(1);
          }
        }
      } else if (newtime.isBefore(b) && newtime.isAfter(a)) {
        // Perfect
        daynighticoncolor = Colors.amber;
        daynighticon = WeatherIcons.day_sunny;
        var diff1 = b.difference(newtime);
        int hr = diff1.inHours;
        double min = diff1.inMinutes / 60 - hr;

        double sum = hr + min;
        diff = sum.toStringAsFixed(1);
      }

      time = newtime.toString().substring(11, 16);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft, //00xfff282627
            //colors: [Colors.cyan, Color(0xFFFe721a2)]
            // colors: [Colors.blue, Colors.pink],
            // colors: [
            //   Colors.pink,
            //   Color(0xFFFE0ABF0),
            //   Color(0xFFF9D97F5),
            // ],
            colors: [Color(0xfff282627), Colors.black],
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                  ),
                  onSubmitted: (value) {
                    cityName = value;

                    void a() async {
                      var weatherData = await weather.getCityWeather(cityName);

                      updateUI(weatherData);
                    }

                    a();
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () => _controller.clear(),
                      icon: Icon(
                        Icons.ac_unit,
                        color: Colors.white,
                      ),
                    ),
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Comfortaa',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: OutlineButton(
                      color: Colors.white,
                      disabledBorderColor: Colors.grey,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();

                        updateUI(weatherData);
                      },
                      child: Text(
                        cityName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 40),
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              //    ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      weatherIcon,
                      size: 200,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white, //Color(0xFFF8F8F8F),
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   // width: 25,
              //   height: 150,
              // ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                WeatherIcons.windy,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  '$windspeed km/h',
                                  style: knewlocstyle,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                WeatherIcons.raindrops,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  '$humidity%',
                                  style: knewlocstyle,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                daynighticon,
                                color: daynighticoncolor,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  '${diff}h',
                                  style: knewlocstyle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          //, bottom: 50, top: 40, left: 20
                          right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '$temperature°',
                            style: TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
