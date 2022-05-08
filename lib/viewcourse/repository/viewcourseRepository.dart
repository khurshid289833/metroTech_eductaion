import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/viewcourse/model/viewcourseModel.dart';

class ViewCourseRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ViewCourseModel> viewCourse(String courseid, String token) async {
    final response = await _helper.getWithHeader("api/display-ongoing-course?course_id=$courseid", "Bearer " + token);
    return ViewCourseModel.fromJson(response);
  }
}
