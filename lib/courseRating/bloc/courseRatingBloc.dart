import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/courseRating/model/courseRatingModel.dart';
import 'package:metrotech_education/courseRating/repository/courseRatingRepository.dart';

class CourseRatingBloc {
  CourseRatingRepository _courseRatingRepository;
  StreamController _streamController;

  StreamSink<ApiResponse<CourseRatingModel>> get courseRatingSink => _streamController.sink;
  Stream<ApiResponse<CourseRatingModel>> get courseRatingStream => _streamController.stream;

  CourseRatingBloc(){
    _courseRatingRepository = CourseRatingRepository();
    _streamController = StreamController<ApiResponse<CourseRatingModel>>.broadcast();
  }

  CourseRatingBlocFunction(body,String token)async{
    courseRatingSink.add(ApiResponse.loading("Fetching"));
    try{
      CourseRatingModel response = await _courseRatingRepository.CourseRatingRepositoryFunction(body, token);
      courseRatingSink.add(ApiResponse.completed(response));
    }catch(e){
      courseRatingSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _streamController?.close();
  }

}