import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/instructorDetails/model/instructorDetailsModel.dart';

class InstructorDetailsRepository{
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<InstructorDetailsModel> InstructorDetailsRepositoryFunction(int instructor_id) async {
    final response = await _helper.get("api/display-ins-rating?instructor_id=$instructor_id");
    return InstructorDetailsModel.fromJson(response);
  }
}