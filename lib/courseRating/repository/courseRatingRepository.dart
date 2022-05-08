import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/courseRating/model/courseRatingModel.dart';

class CourseRatingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CourseRatingModel> CourseRatingRepositoryFunction(body,String token) async {
    final response = await _helper.postWithHeader("api/course-rating", body, "Bearer " + token);
    return CourseRatingModel.fromJson(response);

  }

}