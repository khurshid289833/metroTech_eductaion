class CategoriesModel {
  List<Data> data;

  CategoriesModel({this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
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
  String categoryName;
  String categoryDesc;
  String categoryLogo;
  List<Subcategory> subcategory;

  Data(
      {this.id,
      this.categoryName,
      this.categoryDesc,
      this.categoryLogo,
      this.subcategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryDesc = json['category_desc'];
    categoryLogo = json['category_logo'];
    if (json['subcategory'] != null) {
      subcategory = new List<Subcategory>();
      json['subcategory'].forEach((v) {
        subcategory.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_desc'] = this.categoryDesc;
    data['category_logo'] = this.categoryLogo;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  int id;
  String subCategoryName;
  String creatorNotes;
  List<Topic> topic;

  Subcategory({this.id, this.subCategoryName, this.creatorNotes, this.topic});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryName = json['sub_category_name'];
    creatorNotes = json['creator_notes'];
    if (json['topic'] != null) {
      topic = new List<Topic>();
      json['topic'].forEach((v) {
        topic.add(new Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_name'] = this.subCategoryName;
    data['creator_notes'] = this.creatorNotes;
    if (this.topic != null) {
      data['topic'] = this.topic.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topic {
  int id;
  String topicName;
  String topicDesc;
  String topicLogo;

  Topic({this.id, this.topicName, this.topicDesc, this.topicLogo});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicName = json['topic_name'];
    topicDesc = json['topic_desc'];
    topicLogo = json['topic_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic_name'] = this.topicName;
    data['topic_desc'] = this.topicDesc;
    data['topic_logo'] = this.topicLogo;
    return data;
  }
}
