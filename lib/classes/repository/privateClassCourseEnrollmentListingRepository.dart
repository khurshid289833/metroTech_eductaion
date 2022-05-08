import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/classes/model/privateClassCourseEnrollmentModel.dart';

class PrivateClassCourseEnrollmentListingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<PrivateClassCourseEnrollmentListingModel> PrivateClassCourseEnrollmentListingRepositoryFunction(String token) async {
    final response = await _helper.getWithHeader("api/course-enrollment-listing-for-private-class","Bearer " + token);
    return PrivateClassCourseEnrollmentListingModel.fromJson(response);
  }
}