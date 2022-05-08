import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/main.dart';
import 'package:metrotech_education/signupotp/bloc/resendotpBloc.dart';
import 'package:metrotech_education/signupotp/bloc/signupotpBloc.dart';
import 'package:metrotech_education/signupotp/model/resendotpModel.dart';
import 'model/signupotpModel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignupOtp extends StatefulWidget {
  final String emailId;
  SignupOtp(this.emailId, {Key key}) : super(key: key);

  @override
  _SignupOtpState createState() => _SignupOtpState(emailId);
}

class _SignupOtpState extends State<SignupOtp> {
  final String emailId;
  _SignupOtpState(this.emailId);

  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool streamCheck = false;
  SignupOtpBloc _signupotpbloc;
  ResendOtpBloc _resendOtpBloc;

  @override
  void initState() {
    _signupotpbloc = SignupOtpBloc();
    _resendOtpBloc = ResendOtpBloc();
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Verification',
                  style: TextStyle(
                      fontSize: w * 0.08,
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(39, 39, 39, 1)),
                ),
              ),
              SizedBox(height: h * 0.07),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Your One Time Password has been sent to',
                  style: TextStyle(
                      fontSize: w * 0.035,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(130, 130, 130, 1)),
                ),
              ),
              SizedBox(height: h * 0.005),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'your email ${emailId}',
                  style: TextStyle(
                      fontSize: w * 0.035,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(130, 130, 130, 1)),
                ),
              ),
              SizedBox(height: h * 0.09),
              Container(
                margin: EdgeInsets.only(left: w * 0.08, right: w * 0.08),
                child: PinCodeTextField(
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter OTP sent to your registered email id";
                    // else if (val.length<6)
                    //   return "OTP must content 6 characters";
                    else
                      return null;
                  },
                  appContext: context,
                  length: 6,
                  backgroundColor: Colors.white24,
                  cursorColor: Color.fromRGBO(156, 175, 23, 1),
                  textStyle: TextStyle(fontWeight: FontWeight.w400),
                  enableActiveFill: true,
                  controller: otpController,
                  onChanged: (value) {
                    print(value);
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderWidth: 1.0,
                    fieldHeight: h * 0.055,
                    fieldWidth: w * 0.11,
                    inactiveColor: Color.fromRGBO(130, 130, 130, 1),
                    activeColor: Color.fromRGBO(84, 201, 165, 1),
                    selectedColor: Color.fromRGBO(156, 175, 23, 1),
                    inactiveFillColor: Color.fromRGBO(255, 255, 255, 1),
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                  ),
                  // onCompleted: (value){
                  // },
                ),
              ),
              SizedBox(height: h * 0.06),
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
                        "email": emailId,
                        "otp": otpController.text,
                      };
                      print(body);
                      streamCheck = true;
                      _signupotpbloc.SignupOtpBody(body);
                    }
                  },
                  child: StreamBuilder<ApiResponse<SignupOtpModel>>(
                      stream: _signupotpbloc.signupotpStream,
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
                                if (snapshot.data.data.success == "OTP verified successfully") {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.SCALE,
                                        title: 'Success!',
                                        desc: 'OTP verified successfully',
                                        btnOkOnPress: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()),);
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
                                        title: 'Error!',
                                        desc: 'OTP mismatched',
                                        btnOkColor: Colors.blue,
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
                                      desc: 'Something went wrong please try again!',
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
                            'Verify',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                    padding: EdgeInsets.only(left: w * 0.065),
                    child: Text(
                      'Didn\'t receive the verification OTP?',
                      style: TextStyle(
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(172, 171, 171, 1),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.065),
                    child: InkWell(
                      onTap: () {
                        Map body = {
                          "email": emailId,
                        };
                        print(body);
                        streamCheck = true;
                        _resendOtpBloc.ResendOtpBlocFunction(body);
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(84, 201, 165, 1),
                                )),
                          ),
                        );
                      },
                      child: StreamBuilder<ApiResponse<ResendOtpModel>>(
                          stream: _resendOtpBloc.resendOtpStream,
                          builder: (context, snapshot) {
                            if (streamCheck) {
                              if (snapshot.hasData) {
                                switch (snapshot.data.status) {
                                  case Status.LOADING:
                                    break;

                                  case Status.COMPLETED:
                                    streamCheck = false;
                                    Navigator.pop(context);
                                    if (snapshot.data.data.success ==
                                        "OTP resend successfully") {
                                      Fluttertoast.showToast(
                                          msg: snapshot.data.data.success,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 20,
                                          backgroundColor: Color.fromRGBO(
                                              114, 111, 111, 0.9),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                    print("api call done");
                                    break;

                                  case Status.ERROR:
                                    streamCheck = false;
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg:
                                            "Something went wrong please try again!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 20,
                                        backgroundColor:
                                            Color.fromRGBO(114, 111, 111, 0.9),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    print("api call not done");
                                    break;
                                }
                              }
                            }
                            return Text(
                              'Resend again',
                              style: TextStyle(
                                fontSize: w * 0.038,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(84, 201, 165, 1),
                              ),
                            );
                          }),
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
