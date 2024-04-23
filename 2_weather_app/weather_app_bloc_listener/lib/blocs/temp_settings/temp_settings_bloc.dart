import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_state.dart';
part 'temp_settings_event.dart';

class TempSettingsBloc extends Bloc<TempSettingsEvent, TempSettingsState> {
  TempSettingsBloc() : super(TempSettingsState.initial()) {
    on<TempSettingsEventToggleTempUnit>(_toggleTempUnit);
  }

  void _toggleTempUnit(
    TempSettingsEventToggleTempUnit event,
    Emitter<TempSettingsState>  emit
  ) {
    emit(state.copyWith(
      tempUnit: state.tempUnit == TempUnit.celsius
          ? TempUnit.fahrenheit : TempUnit.celsius
    ));
    print(state.tempUnit);
  }
}
