class WeatherProperties {
  dynamic temperature;
  dynamic windspeed;
  dynamic humidity;
  dynamic weather;
  String image;
  String weatherText;

  WeatherProperties({
    this.temperature,
    this.windspeed,
    this.humidity,
    this.weather,
    required this.image,
    required this.weatherText,
  });
}