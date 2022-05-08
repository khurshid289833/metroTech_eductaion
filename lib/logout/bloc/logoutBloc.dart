import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/logout/model/logoutModel.dart';
import 'package:metrotech_education/logout/repository/logoutRepository.dart';

class LogoutBloc {
  LogoutRepository _signinRepository;
  StreamController _logoutController;

  StreamSink<ApiResponse<LogoutModel>> get logoutSink => _logoutController.sink;

  Stream<ApiResponse<LogoutModel>> get logoutStream => _logoutController.stream;

  LogoutBloc() {
    _logoutController = StreamController<ApiResponse<LogoutModel>>.broadcast();
    _signinRepository = LogoutRepository();
  }
  logoutBlocFunction(String token) async {
    logoutSink.add(ApiResponse.loading(
      "Fetching",
    ));
    try {
      LogoutModel response = await _signinRepository.logoutRepoFunction(token);
      logoutSink.add(ApiResponse.completed(response));
    } catch (e) {
      logoutSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _logoutController?.close();
  }
}
