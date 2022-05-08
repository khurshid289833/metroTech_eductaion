import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/course/model/enrollModel.dart';
import 'package:metrotech_education/course/repository/enrollRepository.dart';

class EnrollBloc {

  EnrollRepository _enrollRepository;
  StreamController _streamController;

  StreamSink<ApiResponse<EnrollModel>> get enrollSink => _streamController.sink;
  Stream<ApiResponse<EnrollModel>> get enrollStream => _streamController.stream;

  EnrollBloc() {
    _streamController = StreamController<ApiResponse<EnrollModel>>.broadcast();
    _enrollRepository = EnrollRepository();
  }

  Enroll(Map body, String token) async {
    print("body");
    print(body);
    enrollSink.add(ApiResponse.loading('Submitting'));
    try {
      EnrollModel enrollModel = await _enrollRepository.enrollCourse(body, token);
      enrollSink.add(ApiResponse.completed(enrollModel));
    } catch (e) {
      enrollSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}
