class PrivateClassCourseEnrollmentListingModel {
  List<Data> data;

  PrivateClassCourseEnrollmentListingModel({this.data});

  PrivateClassCourseEnrollmentListingModel.fromJson(Map<String, dynamic> json) {
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
  int courseid;
  String courseName;
  String courseLogo;

  Data({this.courseid, this.courseName, this.courseLogo});

  Data.fromJson(Map<String, dynamic> json) {
    courseid = json['courseid'];
    courseName = json['course_name'];
    courseLogo = json['course_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseid'] = this.courseid;
    data['course_name'] = this.courseName;
    data['course_logo'] = this.courseLogo;
    return data;
  }
}
