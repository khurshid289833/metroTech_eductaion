class DashboardModel {
  List<Data> data;

  DashboardModel({this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  int totalCourses;
  int enrolledCourses;
  List<Courses> courses;

  Data({this.totalCourses, this.enrolledCourses, this.courses});

  Data.fromJson(Map<String, dynamic> json) {
    totalCourses = json['total_courses'];
    enrolledCourses = json['enrolled_courses'];
    if (json['courses'] != null) {
      courses = new List<Courses>();
      json['courses'].forEach((v) {
        courses.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_courses'] = this.totalCourses;
    data['enrolled_courses'] = this.enrolledCourses;
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  String courseId;
  String courseName;
  String courseLogo;
  String authorName;
  int totalContent;
  int completedContent;
  dynamic completionPercentage;
  String rating;
  String totalEnrolledStudents;

  Courses(
      {this.courseId,
        this.courseName,
        this.courseLogo,
        this.authorName,
        this.totalContent,
        this.completedContent,
        this.completionPercentage,
        this.rating,
        this.totalEnrolledStudents});

  Courses.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    courseLogo = json['course_logo'];
    authorName = json['author_name'];
    totalContent = json['total_content'];
    completedContent = json['completed_content'];
    completionPercentage = json['completion_percentage'];
    rating = json['rating'];
    totalEnrolledStudents = json['total_enrolled_students'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['course_logo'] = this.courseLogo;
    data['author_name'] = this.authorName;
    data['total_content'] = this.totalContent;
    data['completed_content'] = this.completedContent;
    data['completion_percentage'] = this.completionPercentage;
    data['rating'] = this.rating;
    data['total_enrolled_students'] = this.totalEnrolledStudents;
    return data;
  }
}
