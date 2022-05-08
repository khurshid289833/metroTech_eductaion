class SpecialClassesModel {
  List<Data> data;

  SpecialClassesModel({this.data});

  SpecialClassesModel.fromJson(Map<String, dynamic> json) {
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
  String privateClassName;
  String privateClassDesc;
  List<Course> course;

  Data({this.id, this.privateClassName, this.privateClassDesc, this.course});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    privateClassName = json['private_class_name'];
    privateClassDesc = json['private_class_desc'];
    if (json['course'] != null) {
      course = new List<Course>();
      json['course'].forEach((v) {
        course.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['private_class_name'] = this.privateClassName;
    data['private_class_desc'] = this.privateClassDesc;
    if (this.course != null) {
      data['course'] = this.course.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  int id;
  String courseName;
  int userid;
  String authorName;
  String enrollmentDate;
  List<Meetings> meetings;

  Course(
      {this.id,
        this.courseName,
        this.userid,
        this.authorName,
        this.enrollmentDate,
        this.meetings});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    userid = json['userid'];
    authorName = json['author_name'];
    enrollmentDate = json['enrollment_date'];
    if (json['meetings'] != null) {
      meetings = new List<Meetings>();
      json['meetings'].forEach((v) {
        meetings.add(new Meetings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['userid'] = this.userid;
    data['author_name'] = this.authorName;
    data['enrollment_date'] = this.enrollmentDate;
    if (this.meetings != null) {
      data['meetings'] = this.meetings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meetings {
  String meetingId;
  String topic;
  String agenda;
  String startTime;
  String duration;
  String timezone;
  String joinUrl;

  Meetings(
      {this.meetingId,
        this.topic,
        this.agenda,
        this.startTime,
        this.duration,
        this.timezone,
        this.joinUrl});

  Meetings.fromJson(Map<String, dynamic> json) {
    meetingId = json['meeting_id'];
    topic = json['topic'];
    agenda = json['agenda'];
    startTime = json['start_time'];
    duration = json['duration'];
    timezone = json['timezone'];
    joinUrl = json['join_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meeting_id'] = this.meetingId;
    data['topic'] = this.topic;
    data['agenda'] = this.agenda;
    data['start_time'] = this.startTime;
    data['duration'] = this.duration;
    data['timezone'] = this.timezone;
    data['join_url'] = this.joinUrl;
    return data;
  }
}
