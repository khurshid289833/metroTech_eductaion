import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/course/model/coursePreviewModel.dart';

class CoursePreviewRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CoursePreviewModel> CoursePreviewRepositoryFunction(String courseid) async {
    final response = await _helper.get("api/course-preview?course_id=$courseid");
    return CoursePreviewModel.fromJson(response);
  }
}
