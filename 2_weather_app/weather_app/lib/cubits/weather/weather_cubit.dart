import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository}) : super(WeatherState.initial());
  // {
  //   stream.listen((event) {
  //     print("THIS STATUS :: ${event.status}");
  //   });
  // }

  Future<void> fetchWeather(String city) async {
    // API 호출한 상태로 변경
    emit(state.copyWith(status: WeatherStatus.loading));
    print(state.status);
    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
    } on CustomError catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));
    }
    print("Loaded State ::: $state");
  }
}
