class ViewCourseModel {
  Data data;

  ViewCourseModel({this.data});

  ViewCourseModel.fromJson(Map<String, dynamic> json) {
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
  int courseId;
  String courseLogo;
  String courseName;
  String courseDesc;
  String instructor;
  int instructorId;
  List<CourseContent> courseContent;
  int courseContentCompleted;
  int totalCourseContent;
  String totalCourseCompletionPercentage;
  String rating;
  List<Certificate> certificate;

  Data(
      {this.courseId,
        this.courseLogo,
        this.courseName,
        this.courseDesc,
        this.instructor,
        this.instructorId,
        this.courseContent,
        this.courseContentCompleted,
        this.totalCourseContent,
        this.totalCourseCompletionPercentage,
        this.rating,
        this.certificate});

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseLogo = json['course_logo'];
    courseName = json['course_name'];
    courseDesc = json['course_desc'];
    instructor = json['instructor'];
    instructorId = json['instructor_id'];
    if (json['course_content'] != null) {
      courseContent = new List<CourseContent>();
      json['course_content'].forEach((v) {
        courseContent.add(new CourseContent.fromJson(v));
      });
    }
    courseContentCompleted = json['course_content_completed'];
    totalCourseContent = json['total_course_content'];
    totalCourseCompletionPercentage =
    json['total_course_completion_percentage'];
    rating = json['rating'];
    if (json['certificate'] != null) {
      certificate = new List<Certificate>();
      json['certificate'].forEach((v) {
        certificate.add(new Certificate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_logo'] = this.courseLogo;
    data['course_name'] = this.courseName;
    data['course_desc'] = this.courseDesc;
    data['instructor'] = this.instructor;
    data['instructor_id'] = this.instructorId;
    if (this.courseContent != null) {
      data['course_content'] =
          this.courseContent.map((v) => v.toJson()).toList();
    }
    data['course_content_completed'] = this.courseContentCompleted;
    data['total_course_content'] = this.totalCourseContent;
    data['total_course_completion_percentage'] =
        this.totalCourseCompletionPercentage;
    data['rating'] = this.rating;
    if (this.certificate != null) {
      data['certificate'] = this.certificate.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseContent {
  int id;
  String courseContentName;
  String courseContentDesc;
  int courseContentDetailsCompleted;
  int totalCourseContentDetails;
  String markedAs;
  String completePercentage;
  List<CourseContentDetails> courseContentDetails;
  List<Assessment> assessment;

  CourseContent(
      {this.id,
        this.courseContentName,
        this.courseContentDesc,
        this.courseContentDetailsCompleted,
        this.totalCourseContentDetails,
        this.markedAs,
        this.completePercentage,
        this.courseContentDetails,
        this.assessment});

  CourseContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseContentName = json['course_content_name'];
    courseContentDesc = json['course_content_desc'];
    courseContentDetailsCompleted = json['course_content_details_completed'];
    totalCourseContentDetails = json['total_course_content_details'];
    markedAs = json['marked_as'];
    completePercentage = json['complete_percentage'];
    if (json['course_content_details'] != null) {
      courseContentDetails = new List<CourseContentDetails>();
      json['course_content_details'].forEach((v) {
        courseContentDetails.add(new CourseContentDetails.fromJson(v));
      });
    }
    if (json['assessment'] != null) {
      assessment = new List<Assessment>();
      json['assessment'].forEach((v) {
        assessment.add(new Assessment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_content_name'] = this.courseContentName;
    data['course_content_desc'] = this.courseContentDesc;
    data['course_content_details_completed'] =
        this.courseContentDetailsCompleted;
    data['total_course_content_details'] = this.totalCourseContentDetails;
    data['marked_as'] = this.markedAs;
    data['complete_percentage'] = this.completePercentage;
    if (this.courseContentDetails != null) {
      data['course_content_details'] =
          this.courseContentDetails.map((v) => v.toJson()).toList();
    }
    if (this.assessment != null) {
      data['assessment'] = this.assessment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseContentDetails {
  int id;
  String courseContentDetailsName;
  String courseContentDetailsDesc;
  String courseContentDetailsContent;
  String markedAs;

  CourseContentDetails(
      {this.id,
        this.courseContentDetailsName,
        this.courseContentDetailsDesc,
        this.courseContentDetailsContent,
        this.markedAs});

  CourseContentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseContentDetailsName = json['course_content_details_name'];
    courseContentDetailsDesc = json['course_content_details_desc'];
    courseContentDetailsContent = json['course_content_details_content'];
    markedAs = json['marked_as'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_content_details_name'] = this.courseContentDetailsName;
    data['course_content_details_desc'] = this.courseContentDetailsDesc;
    data['course_content_details_content'] = this.courseContentDetailsContent;
    data['marked_as'] = this.markedAs;
    return data;
  }
}

class Assessment {
  int assessmentId;
  String assessmentName;
  int questionsId;
  String questions;
  String options;
  String optionSample;
  String answer;
  String type;
  String qPoints;
  String selectedAnswer;

  Assessment(
      {this.assessmentId,
        this.assessmentName,
        this.questionsId,
        this.questions,
        this.options,
        this.optionSample,
        this.answer,
        this.type,
        this.qPoints,
        this.selectedAnswer});

  Assessment.fromJson(Map<String, dynamic> json) {
    assessmentId = json['assessment_id'];
    assessmentName = json['assessment_name'];
    questionsId = json['questions_id'];
    questions = json['questions'];
    options = json['options'];
    optionSample = json['option_sample'];
    answer = json['answer'];
    type = json['type'];
    qPoints = json['q_points'];
    selectedAnswer = json['selected_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assessment_id'] = this.assessmentId;
    data['assessment_name'] = this.assessmentName;
    data['questions_id'] = this.questionsId;
    data['questions'] = this.questions;
    data['options'] = this.options;
    data['option_sample'] = this.optionSample;
    data['answer'] = this.answer;
    data['type'] = this.type;
    data['q_points'] = this.qPoints;
    data['selected_answer'] = this.selectedAnswer;
    return data;
  }
}

class Certificate {
  String certificateId;
  String userName;
  String courseName;
  String path;
  String createdAt;

  Certificate(
      {this.certificateId,
        this.userName,
        this.courseName,
        this.path,
        this.createdAt});

  Certificate.fromJson(Map<String, dynamic> json) {
    certificateId = json['certificate_id'];
    userName = json['user_name'];
    courseName = json['course_name'];
    path = json['path'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['certificate_id'] = this.certificateId;
    data['user_name'] = this.userName;
    data['course_name'] = this.courseName;
    data['path'] = this.path;
    data['created_at'] = this.createdAt;
    return data;
  }
}
