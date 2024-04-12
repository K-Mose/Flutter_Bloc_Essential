import 'package:bloc/bloc.dart';
import 'package:bloc_overview/b_theme/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class HydratedThemeBloc extends Bloc<ThemeEvent, ThemeState> with HydratedMixin{
  HydratedThemeBloc() : super(ThemeState.initial()) {
    hydrate();
    
    on<ToggleThemeEvent>((event, emit) {
      emit(state.copyWith(
        appTheme: state.appTheme == AppTheme.light
            ? AppTheme.dart
            : AppTheme.light
      ));
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    print("Theme From Storage: $json");
    final themeState = ThemeState.fromJson(json);
    print("ThemeState: $themeState");
    return themeState;
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    print("ThemeState to Storage: $state");
    final themeJson = state.toJson();
    print("ThemeJson: $themeJson");
    return themeJson;
  }
}

