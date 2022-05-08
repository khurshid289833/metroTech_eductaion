class DiscusssionForumModel {
  Data data;

  DiscusssionForumModel({this.data});

  DiscusssionForumModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Comments> comments;

  Data({this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int id;
  String courseId;
  String userId;
  String comment;
  Null parentId;
  String fullname;
  String profilePic;
  String createdAt;
  String timePassed;
  List<Replies> replies;

  Comments(
      {this.id,
        this.courseId,
        this.userId,
        this.comment,
        this.parentId,
        this.fullname,
        this.profilePic,
        this.createdAt,
        this.timePassed,
        this.replies});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    comment = json['comment'];
    parentId = json['parent_id'];
    fullname = json['fullname'];
    profilePic = json['profile_pic'];
    createdAt = json['created_at'];
    timePassed = json['time_passed'];
    if (json['replies'] != null) {
      replies = new List<Replies>();
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['comment'] = this.comment;
    data['parent_id'] = this.parentId;
    data['fullname'] = this.fullname;
    data['profile_pic'] = this.profilePic;
    data['created_at'] = this.createdAt;
    data['time_passed'] = this.timePassed;
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  int id;
  String courseId;
  String userId;
  String comment;
  String parentId;
  String fullname;
  String profilePic;
  String createdAt;
  String timePassed;

  Replies(
      {this.id,
        this.courseId,
        this.userId,
        this.comment,
        this.parentId,
        this.fullname,
        this.profilePic,
        this.createdAt,
        this.timePassed});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    comment = json['comment'];
    parentId = json['parent_id'];
    fullname = json['fullname'];
    profilePic = json['profile_pic'];
    createdAt = json['created_at'];
    timePassed = json['time_passed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['comment'] = this.comment;
    data['parent_id'] = this.parentId;
    data['fullname'] = this.fullname;
    data['profile_pic'] = this.profilePic;
    data['created_at'] = this.createdAt;
    data['time_passed'] = this.timePassed;
    return data;
  }
}
