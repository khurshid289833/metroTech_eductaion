class TopCoursesModel {
  Courses courses;

  TopCoursesModel({this.courses});

  TopCoursesModel.fromJson(Map<String, dynamic> json) {
    courses =
    json['courses'] != null ? new Courses.fromJson(json['courses']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses.toJson();
    }
    return data;
  }
}

class Courses {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;

  Courses(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to});

  Courses.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    return data;
  }
}

class Data {
  int id;
  String courseName;
  String courseShortDesc;
  String courseLogo;
  String coursePrice;
  String author;
  String rating;

  Data(
      {this.id,
        this.courseName,
        this.courseShortDesc,
        this.courseLogo,
        this.coursePrice,
        this.author,
        this.rating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    courseShortDesc = json['course_short_desc'];
    courseLogo = json['course_logo'];
    coursePrice = json['course_price'];
    author = json['author'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['course_short_desc'] = this.courseShortDesc;
    data['course_logo'] = this.courseLogo;
    data['course_price'] = this.coursePrice;
    data['author'] = this.author;
    data['rating'] = this.rating;
    return data;
  }
}
