import 'package:weather_app/exception/weather_exception.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/services/weater_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  const WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding = 
          await weatherApiServices.getDirectGeocoding(city);
      print("directGeocoding: $directGeocoding");

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);
      print("tempWeather: $tempWeather");
      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );
      print("Weather: $weather");
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}