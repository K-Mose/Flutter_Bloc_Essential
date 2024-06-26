part of 'weather_cubit.dart';

// 통신 상태를 알리는 indicator 역할을 하는 status
enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final CustomError error;

  const WeatherState({
    required this.status,
    required this.weather,
    required this.error,
  });


  factory WeatherState.initial() =>
      WeatherState(
        status: WeatherStatus.initial,
        weather: Weather.initial(),
        error: const CustomError()
      );

  @override
  List<Object> get props => [status, weather, error];

  @override
  String toString() {
    return 'WeatherState{status: $status, weather: $weather, error: $error}';
  }

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    CustomError? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

}
