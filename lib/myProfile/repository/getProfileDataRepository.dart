import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/myProfile/model/getProfileDataModel.dart';

class GetProfileDataRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<GetProfileDataModel> GetProfileDataRepositoryFunction(String token) async {
    Map body = {};
    final response = await _helper.postWithHeader("api/profile", body, "Bearer " + token);
    return GetProfileDataModel.fromJson(response);
  }
}
