import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/viewcourse/model/courseCompletionModel.dart';

class CourseCompletionRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CourseCompletionModel> courseCompletionRepoFunction(body, String token) async {
    final response = await _helper.postWithHeader("api/course-completion", body, "Bearer " + token);
    return CourseCompletionModel.fromJson(response);
  }
}
