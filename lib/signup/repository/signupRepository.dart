import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/signup/model/signupModel.dart';

class SignupRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SignupModel> signupRegister(body) async {
    final response = await _helper.post("api/register", body);
    return SignupModel.fromJson(response);
  }
}
