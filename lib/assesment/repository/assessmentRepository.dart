import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/assesment/model/assessmentModel.dart';

class AssessmentRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AssessmentModel> AssessmentRepositoryFunction(body, String token) async {
    final response = await _helper.postWithHeader("api/answer-assessment", body, "Bearer " + token);
    return AssessmentModel.fromJson(response);
  }
}
