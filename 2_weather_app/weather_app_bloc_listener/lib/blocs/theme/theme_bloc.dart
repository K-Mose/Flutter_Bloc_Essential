import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/constants/constants.dart';

part 'theme_state.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ThemeEventChangeTheme>((event, emit) {
      emit(state.copyWith(appTheme: event.appTheme));
    });
  }

  void setTheme(double currentTemp) {
    if (currentTemp > kWarnOrNot) {
      add(const ThemeEventChangeTheme(appTheme: AppTheme.light));
    } else {
      add(const ThemeEventChangeTheme(appTheme: AppTheme.dark));
    }
  }
}
