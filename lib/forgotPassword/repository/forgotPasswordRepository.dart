import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/forgotPassword/model/forgotPasswordModel.dart';

class ForgotPasswordRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ForgotPasswordModel> ForgotPasswordRepositoryFunction(body) async {
    final response = await _helper.post("api/forgot-password", body);
    return ForgotPasswordModel.fromJson(response);
  }
}
