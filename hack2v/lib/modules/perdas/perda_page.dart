import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import '../components/clima_item.dart';
import '../menu/constantes.dart';

class PerdasPage extends StatefulWidget {
  const PerdasPage({super.key});

  @override
  State<PerdasPage> createState() => _PerdasPage();
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      break;
  }
}

class _PerdasPage extends State<PerdasPage> {
  // final TextEditingController _cityController = TextEditingController();
  final Constants _constants = Constants();

  //static String API_KEY = '';

  String location = 'Alfenas';
  String weatherIcon = 'heavycloudy.png';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = '';



  //API Call
  // String searchWeatherAPI = "https://api.weatherapi.com/v1/forecast.json?key=" +
  //     'eab7a8799f49458d9ca20455231105' +
  //     "&days=7&q=";

  // void fetchWeatherData(String searchText) async {
  //   try {
  //     var searchResult =
  //         await http.get(Uri.parse(searchWeatherAPI + searchText));

  //     final weatherData = Map<String, dynamic>.from(
  //         json.decode(searchResult.body) ?? 'No data');

  //     var locationData = weatherData["location"];

  //     var currentWeather = weatherData["current"];

  //     setState(() {
  //       location = getShortLocationName(locationData["name"]);

  //       var parsedDate =
  //           DateTime.parse(locationData["localtime"].substring(0, 10));
  //       var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
  //       currentDate = newDate;

  //       //updateWeather
  //       currentWeatherStatus = currentWeather["condition"]["text"];
  //       weatherIcon =
  //           currentWeatherStatus.replaceAll(' ', '').toLowerCase() + ".png";
  //       temperature = currentWeather["temp_c"].toInt();
  //       windSpeed = currentWeather["wind_kph"].toInt();
  //       humidity = currentWeather["humidity"].toInt();
  //       cloud = currentWeather["cloud"].toInt();

  //       //Forecast data
  //       dailyWeatherForecast = weatherData["forecast"]["forecastday"];
  //       hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
  //       print(dailyWeatherForecast);
  //     });
  //   } catch (e) {
  //     //debugPrint(e);
  //   }
  // }

  // static String getShortLocationName(String s) {
  //   List<String> wordList = s.split(" ");

  //   if (wordList.isNotEmpty) {
  //     if (wordList.length > 1) {
  //       return wordList[0] + " " + wordList[1];
  //     } else {
  //       return wordList[0];
  //     }
  //   } else {
  //     return " ";
  //   }
  // }

  // @override
  // void initState() {
  //   fetchWeatherData(location);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(0),
          color: const Color.fromRGBO(69, 227, 238, 0.712),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                height: size.height * .9,
                decoration: BoxDecoration(
                  gradient: _constants.linearGradientCoffe,
                  boxShadow: [
                    BoxShadow(
                      color: _constants.primaryColor.withOpacity(.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.asset("assets/$weatherIcon"),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Text(
                            temperature.toString(),
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = _constants.shader,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      currentWeatherStatus,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentDate,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Divider(
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Clima(
                            value: windSpeed.toInt(),
                            unit: 'km/h',
                            imageUrl: 'assets/windspeed.png',
                          ),
                          Clima(
                            value: humidity.toInt(),
                            unit: '%',
                            imageUrl: 'assets/humidity.png',
                          ),
                          Clima(
                            value: cloud.toInt(),
                            unit: '%',
                            imageUrl: 'assets/cloud.png',
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
      ]),
    );
  }
}

class BNBCustomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * .20, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .40, 0, size.width * .40, 20);
    path.arcToPoint(Offset(size.width * .60, 20),
        radius: const Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * .60, 0, size.width * .65, 0);
    path.quadraticBezierTo(size.width * .80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
