import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/instructorRating/model/instructorRatingModel.dart';

class InstructorRatingRepository {

  ApiBaseHelper _helper = ApiBaseHelper();
  
  Future<InstructorRatingModel> InstructorRatingRepositoryFunction(body,String token) async {
    final response = await _helper.postWithHeader("api/instructor-rating",body,"Bearer " + token);
    return InstructorRatingModel.fromJson(response);

  }
}