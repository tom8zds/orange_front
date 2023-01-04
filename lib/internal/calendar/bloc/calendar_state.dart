part of 'calendar_bloc.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarFinish extends CalendarState {
  final CalendarData data;

  CalendarFinish(this.data);
}

class CalendarFail extends CalendarState {
  final Object exception;

  CalendarFail(this.exception);
}
