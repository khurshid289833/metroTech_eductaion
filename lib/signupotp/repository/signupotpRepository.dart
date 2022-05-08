import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/signupotp/model/signupotpModel.dart';

class SignupOtpRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SignupOtpModel> signupotp(body) async {
    final response = await _helper.post("api/otp-verification", body);
    return SignupOtpModel.fromJson(response);
  }
}
