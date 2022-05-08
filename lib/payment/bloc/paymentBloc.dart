import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/payment/model/paymentModel.dart';
import 'package:metrotech_education/payment/repository/paymentRepository.dart';

class PaymentBloc {

  PaymentRepository _paymentRepository;
  StreamController _streamController;

  StreamSink<ApiResponse<PaymentModel>> get paymentSink => _streamController.sink;
  Stream<ApiResponse<PaymentModel>> get paymentStream => _streamController.stream;

  PaymentBloc() {
    _streamController = StreamController<ApiResponse<PaymentModel>>.broadcast();
    _paymentRepository = PaymentRepository();
  }
  PaymemntBlocFunction(body, String token) async {
    paymentSink.add(ApiResponse.loading("Fetching",));
    try {
      PaymentModel response = await _paymentRepository.PaymentRepositoryFunction(body, token);
      paymentSink.add(ApiResponse.completed(response));
    } catch (e) {
      paymentSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}