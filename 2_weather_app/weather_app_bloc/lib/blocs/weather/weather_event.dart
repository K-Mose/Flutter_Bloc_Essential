part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object> get props => [];
}

class WeatherEventFetchWeather extends WeatherEvent {
  final String city;

  const WeatherEventFetchWeather({
    required this.city,
  });
}