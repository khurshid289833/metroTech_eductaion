import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/forgotPassword/repository/forgotPasswordRepository.dart';
import 'package:metrotech_education/forgotPassword/model/forgotPasswordModel.dart';

class ForgotPasswordBloc {
  ForgotPasswordRepository _forgotPasswordRepository;
  StreamController _forgotPasswordController;

  StreamSink<ApiResponse<ForgotPasswordModel>> get forgotPasswordSink =>
      _forgotPasswordController.sink;

  Stream<ApiResponse<ForgotPasswordModel>> get forgotPasswordStream =>
      _forgotPasswordController.stream;

  ForgotPasswordBloc() {
    _forgotPasswordController =
        StreamController<ApiResponse<ForgotPasswordModel>>.broadcast();
    _forgotPasswordRepository = ForgotPasswordRepository();
  }
  ForgotPasswordBlocFunction(body) async {
    forgotPasswordSink.add(ApiResponse.loading(
      "Fetching",
    ));
    try {
      ForgotPasswordModel response =
          await _forgotPasswordRepository.ForgotPasswordRepositoryFunction(
              body);
      forgotPasswordSink.add(ApiResponse.completed(response));
    } catch (e) {
      forgotPasswordSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _forgotPasswordController?.close();
  }
}
