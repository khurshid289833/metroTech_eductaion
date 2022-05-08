import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/signup/model/signupModel.dart';
import 'package:metrotech_education/signup/repository/signupRepository.dart';

class SignupBloc {
  SignupRepository _signupRepository;
  StreamController _signupController;

  StreamSink<ApiResponse<SignupModel>> get signupSink => _signupController.sink;

  Stream<ApiResponse<SignupModel>> get signupStream => _signupController.stream;

  SignupBloc() {
    _signupController = StreamController<ApiResponse<SignupModel>>.broadcast();
    _signupRepository = SignupRepository();
  }
  Signup(body) async {
    signupSink.add(ApiResponse.loading(
      "Fetching",
    ));
    try {
      SignupModel response = await _signupRepository.signupRegister(body);
      signupSink.add(ApiResponse.completed(response));
    } catch (e) {
      signupSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _signupController?.close();
  }
}
