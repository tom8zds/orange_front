part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class ModifyServerEvent extends SettingEvent {
  final String server;

  ModifyServerEvent({required this.server});
}

class CheckServerEvent extends SettingEvent {}

class ChangeThemeModeEvent extends SettingEvent {}
