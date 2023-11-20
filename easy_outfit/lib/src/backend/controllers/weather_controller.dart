import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:easy_outfit/src/backend/models/weather_properties.dart';

class WeatherController {
  static const String apiKey = '433146be34a4f0581708c2d3b9a6107f';

  static Future<Map<String, dynamic>> getWeather(String cityName) async {
    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Fallo de conexión');
      }
    } catch (e) {
      throw Exception('No se encontró la ciudad');
    }
  }

  Future<WeatherProperties> getWeatherProperties() async {
    const cityName = "Cali";

    final weatherData = await getWeather(cityName);

    String image = 'assets/clima.png';
    String weatherText = '', weather = '';

    switch (weatherData['weather'][0]['main']) {
      case "Clouds":
        image = 'assets/cluds.png';
        weatherText = 'Cúbrete, puede llover';
        weather= 'Nublado';
        break;

      case "Rain":
        image = 'assets/rain.png';
        weatherText = 'Abrígate, está lloviendo';
        weather= 'Lluvioso';
        break;

      case "Clear":
        image = 'assets/clear.png';
        weatherText = 'Usa tu conjunto favorito';
        weather= 'Soleado';
        break;

      default:
        image = 'assets/clima.png';
        weatherText = 'Condiciones variables';
        weather= 'Variante';
        break;
    }

    return WeatherProperties(
      temperature: (weatherData['main']['temp'] - 273.15).toInt(),
      humidity: weatherData['main']['humidity'],
      windspeed: weatherData['wind']['speed'],
      weather: weather,
      image: image,
      weatherText: weatherText,
    );
  }
}
