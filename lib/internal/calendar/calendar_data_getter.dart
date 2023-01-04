import 'dart:convert';

import 'package:orange_front/internal/calendar/calendar_data.dart';
import 'package:orange_front/internal/common/api_response.dart';
import 'package:orange_front/internal/index/subscribe_index.dart';
import 'package:dio/dio.dart';

import '../setting/setting.dart';

class GetCalendar {
  final Dio dio;
  final SettingRepo _repo = SettingRepo.instance;

  GetCalendar(this.dio);

  Future<CalendarData> call() async {
    Response response = await dio.get(
      "http://${_repo.getServer()}/source/season/",
      options: Options(responseType: ResponseType.json),
      queryParameters: {"year": 2022, "season": 10},
    );
    return CalendarData.fromJson(response.data);
  }
}
