class SearchModel {
  List<Data> data;
  int totalFound;

  SearchModel({this.data, this.totalFound});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    totalFound = json['total_found'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total_found'] = this.totalFound;
    return data;
  }
}

class Data {
  String name;
  List<Result> result;

  Data({this.name, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  String courseName;
  String courseShortDesc;
  String courseLogo;
  String coursePrice;
  String author;
  String rating;

  Result(
      {this.id,
        this.courseName,
        this.courseShortDesc,
        this.courseLogo,
        this.coursePrice,
        this.author,
        this.rating});

  Result.fromJson(Map<String, dynamic> json) {
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
