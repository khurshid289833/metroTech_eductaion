class InstructorDetailsModel {
  List<Data> data;

  InstructorDetailsModel({this.data});

  InstructorDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String fullname;
  String profilePic;
  String rating;
  int review;

  Data({this.id, this.fullname, this.profilePic, this.rating, this.review});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    profilePic = json['profile_pic'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['profile_pic'] = this.profilePic;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}
