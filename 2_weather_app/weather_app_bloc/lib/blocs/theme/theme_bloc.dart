import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/constants/constants.dart';

part 'theme_state.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late final StreamSubscription weatherSubscription;

  final WeatherBloc weatherBloc;
  ThemeBloc({required this.weatherBloc}) : super(ThemeState.initial()) {
    weatherSubscription = weatherBloc.stream.listen((weatherState) {
      if (weatherState.weather.temp > kWarnOrNot) {
        add(const ThemeEventChangeTheme(appTheme: AppTheme.light));
      } else {
        add(const ThemeEventChangeTheme(appTheme: AppTheme.dark));
      }
    });

    on<ThemeEventChangeTheme>((event, emit) {
      emit(state.copyWith(appTheme: event.appTheme));
    });
  }

  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
