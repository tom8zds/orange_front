import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:orange_front/internal/detail/parser_data.dart';
import 'package:orange_front/internal/detail/parser_data_getter.dart';

part 'subscribe_event.dart';
part 'subscribe_state.dart';

class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  final _queryParser = QueryParser(Dio());

  SubscribeBloc() : super(SubscribeInitial()) {
    on<SubscribeEvent>((event, emit) async {
      if (event is QueryParserEvent) {
        emit(ParserLoading());
        try {
          List<ParserData> data = await _queryParser(event.animeName);
          print(data.length);
          emit(ParserDone(data));
        } catch (e, stacktrace) {
          print(e);
          debugPrintStack(stackTrace: stacktrace);
          if (e is Exception) {
            emit(ParserFail(e.toString()));
          }
          emit(ParserFail("unkown"));
        }
      }
    });
  }
}
