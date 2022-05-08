class HomepagePrivateClassListingModel {
  List<Data> data;

  HomepagePrivateClassListingModel({this.data});

  HomepagePrivateClassListingModel.fromJson(Map<String, dynamic> json) {
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
  String price;
  String authorName;

  Data(
      {this.id,
        this.privateClassName,
        this.privateClassDesc,
        this.price,
        this.authorName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    privateClassName = json['private_class_name'];
    privateClassDesc = json['private_class_desc'];
    price = json['price'];
    authorName = json['author_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['private_class_name'] = this.privateClassName;
    data['private_class_desc'] = this.privateClassDesc;
    data['price'] = this.price;
    data['author_name'] = this.authorName;
    return data;
  }
}
