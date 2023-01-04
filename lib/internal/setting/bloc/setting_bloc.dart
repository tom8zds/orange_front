import 'package:orange_front/internal/setting/setting.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingRepo _repo = SettingRepo.instance;

  final dio = Dio();

  Future<bool> checkServer(server) async {
    try {
      if (server != null) {
        final response = await dio.get(
          "http://$server/status",
          options: Options(responseType: ResponseType.json),
        );
        if (response.statusCode == 200) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  SettingBloc() : super(SettingInitial()) {
    on<SettingEvent>((event, emit) async {
      if (event is ModifyServerEvent) {
        emit(SettingLoading());
        print(event.server);
        if (await checkServer(event.server)) {
          _repo.setServer(event.server);
          emit(SettingIdle());
          return;
        }
        emit(SettingError());
      }
      if (event is CheckServerEvent) {
        emit(SettingLoading());
        String? server = _repo.getServer();
        bool flag = await checkServer(server);
        if (flag) {
          emit(SettingIdle());
          return;
        }
        emit(SettingError());
      }
    });
  }
}
