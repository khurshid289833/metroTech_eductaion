import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/course/model/enrollModel.dart';

class EnrollRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<EnrollModel> enrollCourse(Map body, String token) async {
    final response = await _helper.postWithHeader("api/course-enrollment", body, "Bearer $token");
    return EnrollModel.fromJson(response);
  }
}
