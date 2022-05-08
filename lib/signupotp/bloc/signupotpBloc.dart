import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/signupotp/model/signupotpModel.dart';
import 'package:metrotech_education/signupotp/repository/signupotpRepository.dart';

class SignupOtpBloc {
  SignupOtpRepository _signupotpRepository;
  StreamController _signupotpController;

  StreamSink<ApiResponse<SignupOtpModel>> get signupotpSink =>
      _signupotpController.sink;

  Stream<ApiResponse<SignupOtpModel>> get signupotpStream =>
      _signupotpController.stream;

  SignupOtpBloc() {
    _signupotpController =
        StreamController<ApiResponse<SignupOtpModel>>.broadcast();
    _signupotpRepository = SignupOtpRepository();
  }
  SignupOtpBody(body) async {
    signupotpSink.add(ApiResponse.loading(
      "Fetching",
    ));
    try {
      SignupOtpModel response = await _signupotpRepository.signupotp(body);
      signupotpSink.add(ApiResponse.completed(response));
    } catch (e) {
      signupotpSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _signupotpController?.close();
  }
}
