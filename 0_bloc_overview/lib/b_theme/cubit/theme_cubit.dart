import 'package:bloc/bloc.dart';
import 'package:bloc_overview/b_theme/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void changeTheme(int randInt) {
    if (randInt % 2 == 0) {
      emit(state.copyWith(appTheme: AppTheme.light));
    } else {
      emit(state.copyWith(appTheme: AppTheme.dart));
    }
  }
}
