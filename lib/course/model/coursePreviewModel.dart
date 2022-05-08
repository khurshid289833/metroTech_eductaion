class CoursePreviewModel {
  List<Data> data;

  CoursePreviewModel({this.data});

  CoursePreviewModel.fromJson(Map<String, dynamic> json) {
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
  String category;
  String subCategory;
  String topic;
  String courseName;
  String courseDesc;
  String courseLogo;
  String coursePrice;
  String authorName;
  List<CourseContent> courseContent;

  Data(
      {this.id,
      this.category,
      this.subCategory,
      this.topic,
      this.courseName,
      this.courseDesc,
      this.courseLogo,
      this.coursePrice,
      this.authorName,
      this.courseContent});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    subCategory = json['sub_category'];
    topic = json['topic'];
    courseName = json['course_name'];
    courseDesc = json['course_desc'];
    courseLogo = json['course_logo'];
    coursePrice = json['course_price'];
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
    data['id'] = this.id;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['topic'] = this.topic;
    data['course_name'] = this.courseName;
    data['course_desc'] = this.courseDesc;
    data['course_logo'] = this.courseLogo;
    data['course_price'] = this.coursePrice;
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
  String courseContentName;
  String courseContentDesc;
  List<CourseContentDetails> courseContentDetails;

  CourseContent(
      {this.id,
      this.courseContentName,
      this.courseContentDesc,
      this.courseContentDetails});

  CourseContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseContentName = json['course_content_name'];
    courseContentDesc = json['course_content_desc'];
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
    data['course_content_name'] = this.courseContentName;
    data['course_content_desc'] = this.courseContentDesc;
    if (this.courseContentDetails != null) {
      data['course_content_details'] =
          this.courseContentDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseContentDetails {
  int id;
  String courseContentDetailsName;
  String courseContentDetailsDesc;
  String courseContentDetailsContent;

  CourseContentDetails(
      {this.id,
      this.courseContentDetailsName,
      this.courseContentDetailsDesc,
      this.courseContentDetailsContent});

  CourseContentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseContentDetailsName = json['course_content_details_name'];
    courseContentDetailsDesc = json['course_content_details_desc'];
    courseContentDetailsContent = json['course_content_details_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_content_details_name'] = this.courseContentDetailsName;
    data['course_content_details_desc'] = this.courseContentDetailsDesc;
    data['course_content_details_content'] = this.courseContentDetailsContent;
    return data;
  }
}
