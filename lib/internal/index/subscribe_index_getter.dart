import 'package:orange_front/internal/common/api_response.dart';
import 'package:orange_front/internal/index/subscribe_index.dart';
import 'package:orange_front/internal/setting/setting.dart';
import 'package:dio/dio.dart';

class GetSubscribeIndex {
  final Dio dio;
  final SettingRepo _repo = SettingRepo.instance;

  GetSubscribeIndex(this.dio);

  Future<List<SubscribeItem>> call() async {
    Response response = await dio.get("http://${_repo.getServer()}/api/index",
        options: Options(responseType: ResponseType.json));
    ApiResponse apiResponse = ApiResponse.fromJson(response.data);
    return subscribeItemFromJson(apiResponse.data);
  }
}
