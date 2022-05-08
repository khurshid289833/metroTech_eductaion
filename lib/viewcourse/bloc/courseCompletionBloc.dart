import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/viewcourse/model/courseCompletionModel.dart';
import 'package:metrotech_education/viewcourse/repository/courseCompletionRepository.dart';

class CourseCompletionBloc {
  CourseCompletionRepository _courseCompletionRepository;
  StreamController _streamController;

  StreamSink<ApiResponse<CourseCompletionModel>> get courseCompletionSink =>
      _streamController.sink;

  Stream<ApiResponse<CourseCompletionModel>> get courseCompletionStream =>
      _streamController.stream;

  CourseCompletionBloc() {
    _streamController =
        StreamController<ApiResponse<CourseCompletionModel>>.broadcast();
    _courseCompletionRepository = CourseCompletionRepository();
  }

  courseCompletionBlocFunction(body, String token) async {
    print("body");
    courseCompletionSink.add(ApiResponse.loading('Submitting'));
    try {
      CourseCompletionModel courseCompletionModel =
          await _courseCompletionRepository.courseCompletionRepoFunction(
              body, token);
      courseCompletionSink.add(ApiResponse.completed(courseCompletionModel));
    } catch (e) {
      courseCompletionSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}
