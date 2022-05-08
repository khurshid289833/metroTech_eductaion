class ListOfCoursesModel {
  List<Data> data;

  ListOfCoursesModel({this.data});

  ListOfCoursesModel.fromJson(Map<String, dynamic> json) {
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
  String categoryId;
  String subCategoryId;
  String topicId;
  String courseName;
  String courseDesc;
  String courseLogo;
  String coursePrice;
  String authorName;
  String authorEmail;
  String paymentStatus;

  Data(
      {this.id,
      this.categoryId,
      this.subCategoryId,
      this.topicId,
      this.courseName,
      this.courseDesc,
      this.courseLogo,
      this.coursePrice,
      this.authorName,
      this.authorEmail,
      this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    topicId = json['topic_id'];
    courseName = json['course_name'];
    courseDesc = json['course_desc'];
    courseLogo = json['course_logo'];
    coursePrice = json['course_price'];
    authorName = json['author_name'];
    authorEmail = json['author_email'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['topic_id'] = this.topicId;
    data['course_name'] = this.courseName;
    data['course_desc'] = this.courseDesc;
    data['course_logo'] = this.courseLogo;
    data['course_price'] = this.coursePrice;
    data['author_name'] = this.authorName;
    data['author_email'] = this.authorEmail;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}
