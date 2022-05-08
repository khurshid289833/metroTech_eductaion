import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/instructorRating/model/instructorRatingModel.dart';
import 'package:metrotech_education/instructorRating/repository/instructorRatingRepository.dart';

class InstructorRatingBloc {
  StreamController _streamController;
  InstructorRatingRepository _instructorRatingRepository;

  StreamSink<ApiResponse<InstructorRatingModel>> get instructorRatingSink => _streamController.sink;
  Stream<ApiResponse<InstructorRatingModel>> get instructorRatingStream => _streamController.stream;

  InstructorRatingBloc(){
    _streamController = StreamController<ApiResponse<InstructorRatingModel>>.broadcast();
    _instructorRatingRepository = InstructorRatingRepository();
  }
  InstructorRatingBlocFunction(body,String token) async {
    instructorRatingSink.add(ApiResponse.loading("Fetching",));
    try{
      InstructorRatingModel response = await _instructorRatingRepository.InstructorRatingRepositoryFunction(body,token);
      instructorRatingSink.add(ApiResponse.completed(response));
    }catch(e){
      instructorRatingSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  dispose(){
    _streamController?.close();
  }

}