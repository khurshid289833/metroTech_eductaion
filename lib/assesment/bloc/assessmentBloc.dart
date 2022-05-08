import 'dart:async';

import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/assesment/model/assessmentModel.dart';
import 'package:metrotech_education/assesment/repository/assessmentRepository.dart';

class AssessmentBloc {

  AssessmentRepository _assessmentRepository;
  StreamController _streamController;

  StreamSink<ApiResponse<AssessmentModel>> get assessmentSink => _streamController.sink;
  Stream<ApiResponse<AssessmentModel>> get assessmentStream => _streamController.stream;

  AssessmentBloc() {
    _streamController = StreamController<ApiResponse<AssessmentModel>>.broadcast();
    _assessmentRepository = AssessmentRepository();
  }
  AssessmentBlocFunction(body, String token) async {
    assessmentSink.add(ApiResponse.loading("Fetching",));
    try {
      AssessmentModel response = await _assessmentRepository.AssessmentRepositoryFunction(body, token);
      assessmentSink.add(ApiResponse.completed(response));
    } catch (e) {
      assessmentSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}