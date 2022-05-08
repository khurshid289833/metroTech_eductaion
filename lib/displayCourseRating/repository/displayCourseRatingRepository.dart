import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/displayCourseRating/model/displayCourseRatingModel.dart';

class DisplayCourseRatingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DisplayCourseRatingModel> DisplayCourseRatingRepositoryFunction(String course_id) async {
    final response = await _helper.get("api/display-course-rating?course_id=$course_id");
    return DisplayCourseRatingModel.fromJson(response);
  }
}
