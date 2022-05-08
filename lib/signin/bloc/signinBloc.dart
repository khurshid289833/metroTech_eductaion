import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/signin/model/signinlModel.dart';
import 'package:metrotech_education/signin/repository/signinRepository.dart';


class SigninBloc {
  SigninRepository _signinRepository;
  StreamController _signinController;

  StreamSink<ApiResponse<SigninModel>> get signinSink => _signinController.sink;

  Stream<ApiResponse<SigninModel>> get signinStream => _signinController.stream;

  SigninBloc() {
    _signinController = StreamController<ApiResponse<SigninModel>>.broadcast();
    _signinRepository = SigninRepository();
  }
  Signin(body) async {
    signinSink.add(ApiResponse.loading(
      "Fetching",
    ));
    try {
      SigninModel response = await _signinRepository.signin(body);
      signinSink.add(ApiResponse.completed(response));
    } catch (e) {
      signinSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _signinController?.close();
  }
}
