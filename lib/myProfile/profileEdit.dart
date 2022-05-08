import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/myProfile/model/getProfileDataModel.dart';
import 'package:metrotech_education/myProfile/repository/getProfileDataRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

class ProfileEdit extends StatefulWidget {
  final String dob;
  final String altphone;
  final String altemail;
  final String country;
  final String state;
  final String city;
  final String zipcode;
  final String fulladdress;
  final String bio;
  final String insname;
  final String insaddress;
  final String passyear;
  final String qualification;
  ProfileEdit(this.dob,this.altphone,this.altemail,this.country,this.state,this.city,this.zipcode,this.fulladdress,this.bio,this.insname,this.insaddress,this.passyear,this.qualification);
  @override
  _ProfileEditState createState() => _ProfileEditState(dob,altphone,altemail,country,state,city,zipcode,fulladdress,bio,insname,insaddress,passyear,qualification);
}

class _ProfileEditState extends State<ProfileEdit> {
  final String dob;
  final String altphone;
  final String altemail;
  final String country;
  final String state;
  final String city;
  final String zipcode;
  final String fulladdress;
  final String bio;
  final String insname;
  final String insaddress;
  final String passyear;
  final String qualification;
  _ProfileEditState(this.dob,this.altphone,this.altemail,this.country,this.state,this.city,this.zipcode,this.fulladdress,this.bio,this.insname,this.insaddress,this.passyear,this.qualification);

  final _formKey = GlobalKey<FormState>();

  String countryValue;
  String stateValue;
  String cityValue;

  String birthDateInString;
  DateTime birthDate;


  var profile_pic;
  ImagePicker imagePicker = ImagePicker();

  final String url = "http://metrogamingtech.com./api/public/api/st-profile";

  TextEditingController _DOBController;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  TextEditingController _countryController;
  TextEditingController _stateController;
  TextEditingController _cityController;
  TextEditingController _addressController;
  TextEditingController _zipController;
  TextEditingController _bioController;
  TextEditingController _instituteNameController;
  TextEditingController _instituteAddressController;
  TextEditingController _passoutYearController;
  TextEditingController _latestQualificationController;

  Future<GetProfileDataModel> _getProfileDataFuture;
  GetProfileDataRepository _getProfileDataRepository;

  bool vis = false;

  SharedPreferences prefs;
  String picture = "";
  String token = "";

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    picture = prefs.getString("student_picture");
    token = prefs.getString("access_token");
    _DOBController = TextEditingController(text: dob);
    _phoneController = TextEditingController(text: altphone);
    _emailController = TextEditingController(text: altemail);
    _countryController = TextEditingController(text: country);
    _stateController = TextEditingController(text: state);
    _cityController = TextEditingController(text: city);
    _addressController = TextEditingController(text: fulladdress);
    _zipController = TextEditingController(text: zipcode);
    _bioController = TextEditingController(text: bio);
    _instituteNameController = TextEditingController(text: insname);
    _instituteAddressController = TextEditingController(text: insaddress);
    _passoutYearController = TextEditingController(text: passyear);
    _latestQualificationController = TextEditingController(text: qualification);
    setState(() {});
  }

  @override
  void initState() {
    createSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back_pic.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:  Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 0.08),
                child: Center(
                  child: Text(
                    'Edit Your Profile',
                    style: TextStyle(fontSize: w * 0.065, fontWeight: FontWeight.w300, color: Color.fromRGBO(39, 39, 39, 1)),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: h * 0.04, left: w * 0.32),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: w * 0.16,
                      backgroundColor: Color.fromRGBO(67, 196, 185, 1),
                      child: CircleAvatar(
                        radius: w * 0.157,
                        backgroundImage: profile_pic != null ? FileImage(File(profile_pic.path))
                         : picture!=null?NetworkImage("$imageURL${picture}"):AssetImage("images/icon_person.png")
                      ),
                    ),
                    Positioned(
                        top: 75,
                        left: 50,
                        right: 120,
                        //bottom: 00,
                        child: MaterialButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: InkWell(
                                      onTap: () async {
                                        var picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery,imageQuality: 30);
                                        this.setState(() {
                                          profile_pic = picture;
                                          if (profile_pic == null)
                                            print("image null");
                                          else
                                            print("image not null");
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(Icons.photo, size: 50,),
                                    ),
                                  );
                                });
                          },
                          color: Color.fromRGBO(84, 201, 165, 1),
                          // Color.fromRGBO(84, 201, 165, 1),
                          //Color.fromRGBO(156, 175, 23, 1)
                          textColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        )),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06, top: h * 0.05),
                child: TextFormField(
                  controller: _DOBController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter date of birth";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.black38),
                    suffixIcon: GestureDetector(
                        child: new Icon(Icons.calendar_today_outlined,color: Color.fromRGBO(84, 201, 165, 1),),
                        onTap: ()async{
                          final datePick= await showDatePicker(
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: new DateTime(1900),
                              lastDate: new DateTime(2100)
                          );
                          if(datePick!=null && datePick!=birthDate){
                            setState(() {
                              birthDate=datePick;
                              //isDateSelected=true;
                              birthDateInString = "${birthDate.year}/${birthDate.month}/${birthDate.day}"; // 08/14/2019
                              _DOBController.text = birthDateInString;
                            });
                          }
                        }
                    ),
                    hintText: birthDateInString!=null?birthDateInString:'DOB (yyyy-mm-dd)',
                    hintStyle: TextStyle(fontSize: w * 0.035),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06, top: h * 0.02),
                child: TextFormField(
                  controller: _phoneController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter phone number";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.local_phone_outlined, color: Colors.black38),
                    hintText: 'Alternate phone number',
                    hintStyle: TextStyle(fontSize: w * 0.035),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _emailController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter email id";
                    else if (!val.contains("@"))
                      return "Please enter valid email id";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.email_outlined, color: Colors.black38),
                    hintText: 'Alternate email Address',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _countryController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter country name";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.flag_outlined, color: Colors.black38),
                    hintText: 'Country',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _stateController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter state name";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.account_balance, color: Colors.black38),
                    hintText: 'State',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _cityController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter city name";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.location_city_outlined, color: Colors.black38),
                    hintText: 'City',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _zipController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter zip code";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.home_outlined, color: Colors.black38),
                    hintText: 'Zip code',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _addressController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter full address";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.location_on_outlined, color: Colors.black38),
                    hintText: 'Full address',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _bioController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter bio";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.menu_book_outlined, color: Colors.black38),
                    hintText: 'Enter bio',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _instituteNameController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter institute name";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.location_city, color: Colors.black38),
                    hintText: 'Institute name',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _instituteAddressController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter institute address";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.location_on_outlined, color: Colors.black38),
                    hintText: 'Institute address',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _passoutYearController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter pass out year";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.calendar_today_outlined, color: Colors.black38),
                    hintText: 'Pass out year',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06,top: h*0.02),
                child: TextFormField(
                  controller: _latestQualificationController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter latest qualification";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.school_outlined, color: Colors.black38),
                    hintText: 'Latest qualification',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035, //fontWeight: FontWeight.w500
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ),

              Container(
                height: h * 0.06,
                margin: EdgeInsets.only(left: w * 0.2, right: w * 0.2, top: h * 0.07,bottom: h*0.05),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(84, 201, 165, 1),
                        Color.fromRGBO(156, 175, 23, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        vis = true;
                      });
                      var res = await uploadImage();
                    }
                  },
                  child: !vis?Center(
                    child: Text('Update',
                      style: TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ): Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(77, 200, 174, 1)),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadImage() async {

    Map<String, String> headers = { "Authorization": "Bearer " + token};
    final request = new http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    print(_DOBController.text);
    print(_phoneController.text);
    print(_emailController.text);
    print(_addressController.text);
    print(_countryController.text);
    print(_stateController.text);
    print(_cityController.text);
    print(_zipController.text);
    print(_bioController.text);
    print(_instituteNameController.text);
    print(_instituteAddressController.text);
    print(_passoutYearController.text);
    print(_latestQualificationController.text);
    print(token);

    request.fields['date_of_birth'] = _DOBController.text;
    request.fields['alternate_number'] = _phoneController.text;
    request.fields['alternate_email'] = _emailController.text;
    request.fields['full_address'] = _addressController.text;
    request.fields['city'] = _cityController.text;
    request.fields['state'] = _stateController.text;
    request.fields['country'] = _countryController.text;
    request.fields['zipcode'] = _zipController.text;
    request.fields['bio'] = _bioController.text;
    request.fields['institute_name'] = _instituteNameController.text;
    request.fields['institute_address'] = _instituteAddressController.text;
    request.fields['passout_year'] = _passoutYearController.text;
    request.fields['latest_qualification'] = _latestQualificationController.text;

    profile_pic!=null?
    request.files.add(await http.MultipartFile.fromPath('profile_pic',profile_pic.path )) :null;
    // request.files.add(await http.MultipartFile.fromPath('photo_id_proof',photo_id_proof.path ));

    var res = await request.send();

    if (res.statusCode == 200) {

      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: false,
          useRootNavigator: true,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'Success!',
          desc: 'Profile updated successfully',
          btnOkOnPress: () {
            setState(() {
              vis = false;
            });
          }).show();
    }else{
      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: false,
          useRootNavigator: true,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Error!',
          desc: 'Something went wrong please try again',
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            setState(() {
              vis = false;
            });
          }).show();
    }
  }

}
