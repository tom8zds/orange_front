import 'package:orange_front/internal/calendar/calendar_data.dart';
import 'package:orange_front/internal/calendar/calendar_data_getter.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final _getCalendar = GetCalendar(Dio());

  CalendarBloc() : super(CalendarInitial()) {
    on<CalendarEvent>((event, emit) async {
      if (event is GetCalendarEvent) {
        emit(CalendarLoading());
        try {
          CalendarData data = await _getCalendar();
          emit(CalendarFinish(data));
        } catch (e, stacktrace) {
          print(e);
          debugPrintStack(stackTrace: stacktrace);
          if (e is Exception) {
            emit(CalendarFail(e.toString()));
          }
          emit(CalendarFail("unkown"));
        }
      }
    });
  }
}
