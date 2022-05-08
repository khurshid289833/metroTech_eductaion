import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/payment/model/paymentModel.dart';

class PaymentRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<PaymentModel> PaymentRepositoryFunction(body, String token) async {
    final response = await _helper.postWithHeader("api/course-enrollment", body, "Bearer " + token);
    return PaymentModel.fromJson(response);
  }
}