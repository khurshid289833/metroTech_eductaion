class MyCourseModel {
  List<Data> data;

  MyCourseModel({this.data});

  MyCourseModel.fromJson(Map<String, dynamic> json) {
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
  int enrollmentId;
  String courseId;
  String enrollmentDate;
  String courseName;
  String courseDesc;
  String courseLogo;
  String authorName;
  List<CourseContent> courseContent;

  Data(
      {this.enrollmentId,
      this.courseId,
      this.enrollmentDate,
      this.courseName,
      this.courseDesc,
      this.courseLogo,
      this.authorName,
      this.courseContent});

  Data.fromJson(Map<String, dynamic> json) {
    enrollmentId = json['enrollment_id'];
    courseId = json['course_id'];
    enrollmentDate = json['enrollment_date'];
    courseName = json['course_name'];
    courseDesc = json['course_desc'];
    courseLogo = json['course_logo'];
    authorName = json['author_name'];
    if (json['course_content'] != null) {
      courseContent = new List<CourseContent>();
      json['course_content'].forEach((v) {
        courseContent.add(new CourseContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enrollment_id'] = this.enrollmentId;
    data['course_id'] = this.courseId;
    data['enrollment_date'] = this.enrollmentDate;
    data['course_name'] = this.courseName;
    data['course_desc'] = this.courseDesc;
    data['course_logo'] = this.courseLogo;
    data['author_name'] = this.authorName;
    if (this.courseContent != null) {
      data['course_content'] =
          this.courseContent.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseContent {
  int id;
  String courseId;
  String courseContentName;
  List<CourseContentDetails> courseContentDetails;

  CourseContent(
      {this.id,
      this.courseId,
      this.courseContentName,
      this.courseContentDetails});

  CourseContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    courseContentName = json['course_content_name'];
    if (json['course_content_details'] != null) {
      courseContentDetails = new List<CourseContentDetails>();
      json['course_content_details'].forEach((v) {
        courseContentDetails.add(new CourseContentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['course_content_name'] = this.courseContentName;
    if (this.courseContentDetails != null) {
      data['course_content_details'] =
          this.courseContentDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseContentDetails {
  int id;
  String courseContentId;
  String courseContentDetailsName;
  String courseContentDetailsDesc;
  String courseContentDetailsContent;

  CourseContentDetails(
      {this.id,
      this.courseContentId,
      this.courseContentDetailsName,
      this.courseContentDetailsDesc,
      this.courseContentDetailsContent});

  CourseContentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseContentId = json['course_content_id'];
    courseContentDetailsName = json['course_content_details_name'];
    courseContentDetailsDesc = json['course_content_details_desc'];
    courseContentDetailsContent = json['course_content_details_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_content_id'] = this.courseContentId;
    data['course_content_details_name'] = this.courseContentDetailsName;
    data['course_content_details_desc'] = this.courseContentDetailsDesc;
    data['course_content_details_content'] = this.courseContentDetailsContent;
    return data;
  }
}
