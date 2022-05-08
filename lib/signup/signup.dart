import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/signin/signin.dart';
import 'package:metrotech_education/signup/bloc/signupBlock.dart';
import 'package:metrotech_education/signupotp/signupotp.dart';
import 'model/signupModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  String _radioValue;
  bool _passwordVisible1;
  bool _passwordVisible2;
  bool streamCheck = false;

  SignupBloc _signupBloc;

  @override
  void initState() {
    _passwordVisible1 = false;
    _passwordVisible2 = false;
    _signupBloc = SignupBloc();
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
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            children: [
              SizedBox(height: h * 0.08),
              Container(
                height: h * 0.07,
                child: Image.asset('images/logo.png'),
              ),
              //SizedBox(height: h * 0.07),
              // Container(
              //   child: Center(
              //     child: Text(
              //       'Sign up!',
              //       style: GoogleFonts.roboto(
              //           fontSize: w * 0.1, fontWeight: FontWeight.w300),
              //     ),
              //   ),
              // ),
              //SizedBox(height: h * 0.01),
              // Container(
              //   child: Center(
              //     child: Text(
              //       'We are happy to see you here!',
              //       style: GoogleFonts.roboto(
              //           fontSize: w * 0.042,
              //           fontWeight: FontWeight.w600,
              //           color: Color.fromRGBO(77, 200, 174, 1)),
              //       //TextStyle(fontSize: 18.0,fontFamily:'Roboto',color: Color.fromRGBO(77, 200, 174, 1),fontWeight: FontWeight.w500),
              //     ),
              //   ),
              // ),
              SizedBox(height: h * 0.08),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                child: TextFormField(
                  controller: nameController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter your name";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black38,
                    ),
                    hintText: "Full Name",
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
              SizedBox(height: h * 0.02),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                child: TextFormField(
                  controller: emailController,
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
                    hintText: "Email Address",
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
              SizedBox(height: h * 0.02),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                child: TextFormField(
                  controller: phoneController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter mobile number";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.local_phone_outlined, color: Colors.black38),
                    hintText: "Mobile Number",
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
              SizedBox(height: h * 0.03),
              Container(
                margin: EdgeInsets.only(left: w * 0.09, right: w * 0.06),
                child: Text(
                  'Choose Gender',
                  style: TextStyle(fontSize: w * 0.04, color: Colors.black54),
                ),
              ),
              SizedBox(height: h * 0.01),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                child: Row(
                  children: [
                    Radio(
                        value: 'm',
                        groupValue: _radioValue,
                        activeColor: Color.fromRGBO(77, 200, 174, 1),
                        onChanged: (val) {
                          _radioValue = val;
                          setState(() {});
                        }),
                    Text(
                      'Male',
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(width: w * 0.06),
                    Radio(
                        value: 'f',
                        groupValue: _radioValue,
                        activeColor: Color.fromRGBO(77, 200, 174, 1),
                        onChanged: (val) {
                          _radioValue = val;
                          setState(() {});
                        }),
                    Text(
                      'Female',
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(width: w * 0.06),
                    Radio(
                        value: 'o',
                        groupValue: _radioValue,
                        activeColor: Color.fromRGBO(77, 200, 174, 1),
                        onChanged: (val) {
                          _radioValue = val;
                          setState(() {});
                        }),
                    Text(
                      'Others',
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.01),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                child: TextFormField(
                  controller: passwordController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter password";
                    else if (val.length < 8)
                      return "Password must content 8 characters";
                    else
                      return null;
                  },
                  obscureText: !_passwordVisible1,
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.black38),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(fontSize: w * 0.035),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible1
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black38,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible1 = !_passwordVisible1;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                child: TextFormField(
                  controller: confirmpasswordController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter password";
                    else if (val.length < 8)
                      return "Password must content 8 characters";
                    else
                      return null;
                  },
                  obscureText: !_passwordVisible2,
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.black38,
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(fontSize: w * 0.035),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black38,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible2 = !_passwordVisible2;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.05),
              Container(
                height: h * 0.06,
                margin: EdgeInsets.only(left: w * 0.3, right: w * 0.3),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(84, 201, 165, 1),
                        Color.fromRGBO(156, 175, 23, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      Map body = {
                        "role": "3",
                        "fullname": nameController.text,
                        "email": emailController.text,
                        "phoneno": phoneController.text,
                        "gender": _radioValue,
                        "password": passwordController.text,
                        "confirm_password": confirmpasswordController.text,
                      };
                      print(body);
                      streamCheck = true;
                      _signupBloc.Signup(body);
                    }
                  },
                  child: StreamBuilder<ApiResponse<SignupModel>>(
                      stream: _signupBloc.signupStream,
                      builder: (context, snapshot) {
                        if (streamCheck) {
                          if (snapshot.hasData) {
                            switch (snapshot.data.status) {
                              case Status.LOADING:
                                return Container(
                                  height: 2,
                                  width: 2,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color.fromRGBO(77, 200, 174, 1)),
                                    ),
                                  ),
                                );
                                break;

                              case Status.COMPLETED:
                                streamCheck = false;
                                if (snapshot.data.data.success == "You are registered successfully") {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.SCALE,
                                        title: 'Success!',
                                        desc: 'You have registered successfully',
                                        btnOkOnPress: () {
                                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SignupOtp(emailController.text)),);
                                        }).show();
                                  });
                                  print("api call done");
                                }
                                break;

                              case Status.ERROR:
                                streamCheck = false;
                                if (snapshot.data.message.contains("The email has already been taken.") &&
                                    snapshot.data.message.contains("The phoneno has already been taken.")) {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.SCALE,
                                        title: 'Error!',
                                        desc: 'The email and phone number has already been taken',
                                        btnOkColor: Colors.red,
                                        btnOkOnPress: () {}).show();
                                  });
                                } else if (snapshot.data.message.contains("The email has already been taken.")) {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.SCALE,
                                        title: 'Error!',
                                        desc: 'The email has already been taken',
                                        btnOkColor: Colors.red,
                                        btnOkOnPress: () {}).show();
                                  });
                                } else if (snapshot.data.message.contains("The phoneno has already been taken.")) {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.SCALE,
                                        title: 'Error!',
                                        desc: 'The phone number has already been taken',
                                        btnOkColor: Colors.red,
                                        btnOkOnPress: () {}).show();
                                  });
                                } else if (snapshot.data.message.contains("The confirm password and password must match.")) {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.SCALE,
                                        title: 'Error!',
                                        desc: 'The password and confirm password must match',
                                        btnOkColor: Colors.red,
                                        btnOkOnPress: () {}).show();
                                  });
                                } else if (snapshot.data.message.contains("The password must be at least 8 characters.")) {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.SCALE,
                                        title: 'Error!',
                                        desc: 'The password must be at least 8 characters',
                                        btnOkColor: Colors.red,
                                        btnOkOnPress: () {}).show();
                                  });
                                } else {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.SCALE,
                                        title: 'Error!',
                                        desc: 'Something went wrong please try again later!',
                                        btnOkColor: Colors.red,
                                        btnOkOnPress: () {}).show();
                                  });
                                }
                                print("api call not done");
                                break;
                            }
                          }
                        }
                        return Center(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: h * 0.05),
              Container(
                margin: EdgeInsets.only(left: w * 0.28, right: w * 0.22),
                child: Row(
                  children: [
                    Text(
                      'Already a member? ',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: w * 0.037,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signin())),
                      },
                      child: Text(
                        'Signin',
                        style: TextStyle(
                            color: Color.fromRGBO(77, 200, 174, 1),
                            fontSize: w * 0.038,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
