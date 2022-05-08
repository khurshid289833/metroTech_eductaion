import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/signin/model/signinlModel.dart';

class SigninRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SigninModel> signin(body) async {
    final response = await _helper.post("api/login", body);
    return SigninModel.fromJson(response);
  }
}
