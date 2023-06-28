import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:i18n_extension/default.i18n.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../core/app_theme.dart';
import '../../providers/database_user.dart';
import '../components/clima_item.dart';
import 'constantes.dart';
import 'dart:ui' as ui;



class MenuPageV extends GetView<MenuController> {
  const MenuPageV({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: I18n(
        initialLocale: const Locale("pt", "BR"),
        child: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: MenuPage(),
        ),
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      break;
  }
}

class _MenuPage extends State<MenuPage> {
  final TextEditingController _cityController = TextEditingController();
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
  String searchWeatherAPI = "https://api.weatherapi.com/v1/forecast.json?key=" +
      'eab7a8799f49458d9ca20455231105' +
      "&days=7&q=";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherAPI + searchText));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data');

      var locationData = weatherData["location"];

      var currentWeather = weatherData["current"];

      setState(() {
        location = getShortLocationName(locationData["name"]);

        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd', 'pt-BR').format(parsedDate);
        currentDate = newDate;

        //updateWeather
        currentWeatherStatus = currentWeather["condition"]["text"];
        weatherIcon =
            "${currentWeatherStatus.replaceAll(' ', '').toLowerCase()}.png";
        temperature = currentWeather["temp_c"].toInt();
        windSpeed = currentWeather["wind_kph"].toInt();
        humidity = currentWeather["humidity"].toInt();
        cloud = currentWeather["cloud"].toInt();

        //Forecast data
        dailyWeatherForecast = weatherData["forecast"]["forecastday"];
        hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
        print(dailyWeatherForecast);
      });
    } catch (e) {
      //debugPrint(e);
    }
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + " " + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }

  @override
  void initState() {
    fetchWeatherData(location);
    super.initState();
  }

  final db = DataBaseProvider();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: size.height * .54,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/pin.png",
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                location,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  _cityController.clear();
                                  showMaterialModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                            controller:
                                                ModalScrollController.of(
                                                    context),
                                            child: Container(
                                              height: size.height * .6,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 30,
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 70,
                                                    child: Divider(
                                                      thickness: 3.5,
                                                      color: _constants
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 1,
                                                  ),
                                                  TextField(
                                                    onChanged: (searchText) {
                                                      fetchWeatherData(
                                                          searchText);
                                                    },
                                                    controller: _cityController,
                                                    autofocus: true,
                                                    decoration: InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons.search,
                                                          color: _constants
                                                              .primaryColor,
                                                        ),
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () =>
                                                              _cityController
                                                                  .clear(),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: _constants
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        hintText: 'Ex: Alfenas',
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: _constants
                                                                .primaryColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      // Text(
                      //   //currentWeatherStatus.i18n,
                      //   style: const TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 22.0,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      Text(
                        currentDate.toString(),
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
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(top: 10),
                  height: size.height * .24,
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dia',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: hourlyWeatherForecast.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            String currentTime =
                                DateFormat('HH:mm:ss').format(DateTime.now());
                            String currentHour = currentTime.substring(0, 2);

                            String forecastTime = hourlyWeatherForecast[index]
                                    ["time"]
                                .substring(11, 16);
                            String forecastHour = hourlyWeatherForecast[index]
                                    ["time"]
                                .substring(11, 13);

                            String forecastWeatherName =
                                hourlyWeatherForecast[index]["condition"]
                                    ["text"];
                            String forecastWeatherIcon = forecastWeatherName
                                    .replaceAll(' ', '')
                                    .toLowerCase() +
                                ".png";

                            String forecastTemperature =
                                hourlyWeatherForecast[index]["temp_c"]
                                    .round()
                                    .toString();
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              margin: const EdgeInsets.only(right: 20),
                              width: 60,
                              decoration: BoxDecoration(
                                  color: currentHour == forecastHour
                                      ? Color.fromARGB(255, 154, 190, 226)
                                      : Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 1),
                                      blurRadius: 5,
                                      color: _constants.primaryColor
                                          .withOpacity(.2),
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    forecastTime,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 0, 89, 179),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/$forecastWeatherIcon',
                                    width: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        forecastTemperature,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 89, 179),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Text(
                                        '°',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 89, 179),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          fontFeatures: const [
                                            FontFeature.enable('sups'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomePainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.toNamed('/propcadastro');
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 40,
                      ),
                      elevation: 0.1,
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.toNamed('/propinfo');
                            },
                            icon: const Icon(Icons.info_outline),
                            color: Colors.black),
                        SizedBox(
                          height: size.height * 0.06,
                          child: IconButton(
                              onPressed: () {
                                Get.toNamed('/plantio');
                              },
                              icon: Image.asset('assets/plant.png')),
                        ),
                        Container(
                          width: size.width * .20,
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                          child: IconButton(
                            onPressed: () {
                              Get.toNamed('/adubo');
                            },
                            icon: Image.asset('assets/fertilizer.png'),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            db.deslogar();
                            Get.toNamed('/login');
                          },
                          icon: const Icon(Icons.exit_to_app),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
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
