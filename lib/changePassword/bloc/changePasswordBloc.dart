import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/changePassword/model/changePasswordModel.dart';
import 'package:metrotech_education/changePassword/repository/changePasswordRepository.dart';

class ChangePasswordBloc {

  ChangePasswordRepository _changePasswordRepository;
  StreamController _streamController;

  StreamSink<ApiResponse<ChangePasswordModel>> get changePasswordSink => _streamController.sink;
  Stream<ApiResponse<ChangePasswordModel>> get changePasswordStream => _streamController.stream;

  ChangePasswordBloc() {
    _streamController = StreamController<ApiResponse<ChangePasswordModel>>.broadcast();
    _changePasswordRepository = ChangePasswordRepository();
  }
  changePasswordBlocFunction(body, String token) async {
    changePasswordSink.add(ApiResponse.loading("Fetching",));
    try {
      ChangePasswordModel response = await _changePasswordRepository.ChangePasswordRepositoryFunction(body, token);
      changePasswordSink.add(ApiResponse.completed(response));
    } catch (e) {
      changePasswordSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}
