import 'package:flutter/material.dart';
import 'package:easy_outfit/src/backend/controllers/weather_controller.dart';
import 'package:easy_outfit/src/backend/models/weather_properties.dart';

class ClimaSection extends StatelessWidget {
  final WeatherController _weatherController = WeatherController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _weatherController.getWeatherProperties(),
        builder:
            (BuildContext context, AsyncSnapshot<WeatherProperties> snapshot) {
          if (snapshot.hasData) {
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  snapshot.data!.image,
                  width: 120,
                  height: 120,
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.weather,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${snapshot.data!.temperature} \u2103",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      snapshot.data!.weatherText,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ));
          } else {
            return const Center(
              child: Text(
                "No hay conexión a internet",
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        });
  }
}
