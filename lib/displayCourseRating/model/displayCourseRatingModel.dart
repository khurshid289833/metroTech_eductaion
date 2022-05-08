class DisplayCourseRatingModel {
  List<Data> data;

  DisplayCourseRatingModel({this.data});

  DisplayCourseRatingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String courseLogo;
  String courseName;
  double rating;
  int review;

  Data({this.id, this.courseLogo, this.courseName, this.rating, this.review});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseLogo = json['course_logo'];
    courseName = json['course_name'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_logo'] = this.courseLogo;
    data['course_name'] = this.courseName;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}
