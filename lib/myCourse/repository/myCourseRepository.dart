import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/myCourse/model/myCourseModel.dart';

class MyCourseRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<MyCourseModel> MyCourseRepositoryFunction(String token) async {
    final response = await _helper.getWithHeader("api/enrolled-course", "Bearer " + token);
    return MyCourseModel.fromJson(response);
  }
}
