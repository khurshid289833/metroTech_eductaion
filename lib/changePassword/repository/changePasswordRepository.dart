import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/changePassword/model/changePasswordModel.dart';

class ChangePasswordRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ChangePasswordModel> ChangePasswordRepositoryFunction(body, String token) async {
    final response = await _helper.postWithHeader("api/update-password", body, "Bearer " + token);
    return ChangePasswordModel.fromJson(response);
  }
}
