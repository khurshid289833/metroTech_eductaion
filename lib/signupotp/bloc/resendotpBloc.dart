import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/signupotp/model/resendotpModel.dart';
import 'package:metrotech_education/signupotp/repository/resendotpRepository.dart';

class ResendOtpBloc {
  ResendOtpRepository _resendOtpRepository;
  StreamController _resendOtpController;

  StreamSink<ApiResponse<ResendOtpModel>> get resendOtpSink =>
      _resendOtpController.sink;

  Stream<ApiResponse<ResendOtpModel>> get resendOtpStream =>
      _resendOtpController.stream;

  ResendOtpBloc() {
    _resendOtpController =
        StreamController<ApiResponse<ResendOtpModel>>.broadcast();
    _resendOtpRepository = ResendOtpRepository();
  }
  ResendOtpBlocFunction(body) async {
    resendOtpSink.add(ApiResponse.loading(
      "Fetching",
    ));
    try {
      ResendOtpModel response =
          await _resendOtpRepository.ResendOtpRepositoryFunction(body);
      resendOtpSink.add(ApiResponse.completed(response));
    } catch (e) {
      resendOtpSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _resendOtpController?.close();
  }
}
