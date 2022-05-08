import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/displayInstructorRating/model/displayInstructorRatingModel.dart';

class DisplayInstructorRatingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DisplayInstructorRatingModel> DisplayInstructorRatingRepositoryFunction(int instructor_id) async {
    final response = await _helper.get("api/display-ins-rating?instructor_id=$instructor_id");
    return DisplayInstructorRatingModel.fromJson(response);
  }
}