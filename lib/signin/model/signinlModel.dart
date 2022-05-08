class SigninModel {
  String accessToken;
  int expiry;
  List<Data> data;

  SigninModel({this.accessToken, this.expiry, this.data});

  SigninModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiry = json['expiry'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expiry'] = this.expiry;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String role;
  String fullname;
  String email;
  String phoneno;
  String gender;
  String uniqueId;
  String ucreatedat;
  String dateOfBirth;
  String alternateNumber;
  String alternateEmail;
  String fullAddress;
  String city;
  String state;
  String country;
  String zipcode;
  String instituteName;
  String instituteAddress;
  String passoutYear;
  String latestQualification;
  String workingExperience;
  String workingPlace;
  String workingPlaceAddress;
  String workingPlaceEmail;
  String profilePic;
  String photoIdProof;
  String addressProof;
  String dobProof;
  String qualificationProof;
  String workingExpProof;

  Data(
      {this.role,
      this.fullname,
      this.email,
      this.phoneno,
      this.gender,
      this.uniqueId,
      this.ucreatedat,
      this.dateOfBirth,
      this.alternateNumber,
      this.alternateEmail,
      this.fullAddress,
      this.city,
      this.state,
      this.country,
      this.zipcode,
      this.instituteName,
      this.instituteAddress,
      this.passoutYear,
      this.latestQualification,
      this.workingExperience,
      this.workingPlace,
      this.workingPlaceAddress,
      this.workingPlaceEmail,
      this.profilePic,
      this.photoIdProof,
      this.addressProof,
      this.dobProof,
      this.qualificationProof,
      this.workingExpProof});

  Data.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    fullname = json['fullname'];
    email = json['email'];
    phoneno = json['phoneno'];
    gender = json['gender'];
    uniqueId = json['unique_id'];
    ucreatedat = json['ucreatedat'];
    dateOfBirth = json['date_of_birth'];
    alternateNumber = json['alternate_number'];
    alternateEmail = json['alternate_email'];
    fullAddress = json['full_address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipcode = json['zipcode'];
    instituteName = json['institute_name'];
    instituteAddress = json['institute_address'];
    passoutYear = json['passout_year'];
    latestQualification = json['latest_qualification'];
    workingExperience = json['working_experience'];
    workingPlace = json['working_place'];
    workingPlaceAddress = json['working_place_address'];
    workingPlaceEmail = json['working_place_email'];
    profilePic = json['profile_pic'];
    photoIdProof = json['photo_id_proof'];
    addressProof = json['address_proof'];
    dobProof = json['dob_proof'];
    qualificationProof = json['qualification_proof'];
    workingExpProof = json['working_exp_proof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phoneno'] = this.phoneno;
    data['gender'] = this.gender;
    data['unique_id'] = this.uniqueId;
    data['ucreatedat'] = this.ucreatedat;
    data['date_of_birth'] = this.dateOfBirth;
    data['alternate_number'] = this.alternateNumber;
    data['alternate_email'] = this.alternateEmail;
    data['full_address'] = this.fullAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['institute_name'] = this.instituteName;
    data['institute_address'] = this.instituteAddress;
    data['passout_year'] = this.passoutYear;
    data['latest_qualification'] = this.latestQualification;
    data['working_experience'] = this.workingExperience;
    data['working_place'] = this.workingPlace;
    data['working_place_address'] = this.workingPlaceAddress;
    data['working_place_email'] = this.workingPlaceEmail;
    data['profile_pic'] = this.profilePic;
    data['photo_id_proof'] = this.photoIdProof;
    data['address_proof'] = this.addressProof;
    data['dob_proof'] = this.dobProof;
    data['qualification_proof'] = this.qualificationProof;
    data['working_exp_proof'] = this.workingExpProof;
    return data;
  }
}
