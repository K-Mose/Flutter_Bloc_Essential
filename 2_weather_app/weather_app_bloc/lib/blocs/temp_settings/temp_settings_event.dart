part of 'temp_settings_bloc.dart';

sealed class TempSettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TempSettingsEventToggleTempUnit extends TempSettingsEvent {}