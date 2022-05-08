import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/signupotp/model/resendotpModel.dart';

class ResendOtpRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ResendOtpModel> ResendOtpRepositoryFunction(body) async {
    final response = await _helper.post("api/resend-otp", body);
    return ResendOtpModel.fromJson(response);
  }
}
