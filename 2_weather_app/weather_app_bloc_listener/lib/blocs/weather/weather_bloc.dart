import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';
part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherState.initial()) {
    on<WeatherEventFetchWeather>(_fetchWeather);
  }



  Future<void> _fetchWeather(
    WeatherEventFetchWeather event,
    Emitter<WeatherState> emit
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final Weather weather = await weatherRepository.fetchWeather(event.city);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
    } on CustomError catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));
    }
    print("Loaded State ::: $state");
  }
}
