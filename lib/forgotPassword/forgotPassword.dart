import 'package:flutter/material.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/forgotPassword/bloc/forgotPasswordBloc.dart';
import 'package:metrotech_education/forgotPassword/model/forgotPasswordModel.dart';
import 'package:metrotech_education/signin/signin.dart';
import 'package:metrotech_education/signup/signup.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool streamCheck = false;
  ForgotPasswordBloc _forgotPasswordBloc;

  @override
  void initState() {
    _forgotPasswordBloc = ForgotPasswordBloc();
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
              SizedBox(height: h * 0.1),
              Container(
                child: Center(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontSize: w * 0.065,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(39, 39, 39, 1)),
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
              Container(
                child: Center(
                  child: Text(
                    'We just need your registered email address',
                    style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(130, 130, 130, 1)),
                  ),
                ),
              ),
              SizedBox(height: h * 0.005),
              Container(
                child: Center(
                  child: Text(
                    'to send you password reset',
                    style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(130, 130, 130, 1)),
                  ),
                ),
              ),
              SizedBox(height: h * 0.09),
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
                    hintText: 'Email Address',
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
              SizedBox(height: h * 0.1),
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
                        "email": emailController.text,
                      };
                      print(body);
                      streamCheck = true;
                      _forgotPasswordBloc.ForgotPasswordBlocFunction(body);
                    }
                  },
                  child: StreamBuilder<ApiResponse<ForgotPasswordModel>>(
                      stream: _forgotPasswordBloc.forgotPasswordStream,
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
                                        Color.fromRGBO(84, 201, 165, 1),
                                      ),
                                    ),
                                  ),
                                );
                                break;

                              case Status.COMPLETED:
                                streamCheck = false;
                                if (snapshot.data.data.success == "Password reset successfully. Check your registered email") {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.SCALE,
                                        title: 'Success!',
                                        desc: 'Password reset successfully please check your registered email id',
                                        btnOkOnPress: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()),);
                                        }).show();
                                  });
                                } else {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.INFO,
                                        animType: AnimType.SCALE,
                                        btnOkColor: Colors.blue,
                                        title: 'Info!',
                                        desc: 'This email id is not registered with us',
                                        btnOkOnPress: () {}).show();
                                  });
                                }
                                print("api call done");
                                break;

                              case Status.ERROR:
                                streamCheck = false;
                                Future.delayed(Duration.zero, () async {
                                  AwesomeDialog(
                                      context: context,
                                      dismissOnTouchOutside: false,
                                      useRootNavigator: true,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.SCALE,
                                      title: 'Error!',
                                      desc: 'Something went wrong please try again',
                                      btnOkColor: Colors.red,
                                      btnOkOnPress: () {}).show();
                                });
                                print("api call not done");
                                break;
                            }
                          }
                        }
                        return Center(
                          child: Text(
                            'Reset',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: h * 0.02),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.21),
                    child: Text(
                      'Didn\'t have an account?',
                      style: TextStyle(
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(172, 171, 171, 1),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.21),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: w * 0.038,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(84, 201, 165, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
