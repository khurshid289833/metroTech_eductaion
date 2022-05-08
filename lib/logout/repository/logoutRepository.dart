import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/logout/model/logoutModel.dart';

class LogoutRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<LogoutModel> logoutRepoFunction(String token) async {
    final response =
        await _helper.getWithHeader("api/logout", "Bearer " + token);
    return LogoutModel.fromJson(response);
  }
}
