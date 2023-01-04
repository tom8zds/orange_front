import 'package:orange_front/internal/common/api_response.dart';
import 'package:orange_front/internal/index/subscribe_index.dart';
import 'package:orange_front/internal/index/subscribe_index_getter.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'subscribe_index_event.dart';
part 'subscribe_index_state.dart';

class SubscribeIndexBloc
    extends Bloc<SubscribeIndexEvent, SubscribeIndexState> {
  final GetSubscribeIndex _getSubscribeIndex = GetSubscribeIndex(Dio());

  SubscribeIndexBloc() : super(SubscribeIndexInitial()) {
    on<SubscribeIndexEvent>((event, emit) async {
      if (event is GetSubscribeIndexEvent) {
        emit(SubscribeIndexLoading());
        try {
          List<SubscribeItem> data = await _getSubscribeIndex();
          emit(SubscribeIndexFinish(data));
        } catch (e, stacktrace) {
          print(e);
          if (e is Exception) {
            emit(SubscribeIndexFail(e.toString()));
          }
          emit(SubscribeIndexFail("unkown"));
        }
      }
    });
  }
}
