import 'dart:convert';

import 'package:orange_front/internal/detail/parser_data.dart';
import 'package:dio/dio.dart';

import '../setting/setting.dart';

class QueryParser {
  final Dio dio;
  final SettingRepo _repo = SettingRepo.instance;

  QueryParser(this.dio);

  Future<List<ParserData>> call(String animeName) async {
    Response response = await dio.get(
      "http://${_repo.getServer()}/parser/search/$animeName",
      options: Options(responseType: ResponseType.json),
    );
    return parserDataFromJson(response.data);
  }
}
