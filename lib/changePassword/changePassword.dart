import 'package:flutter/material.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/changePassword/bloc/changePasswordBloc.dart';
import 'package:metrotech_education/changePassword/model/changePasswordModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ChangePassword extends StatefulWidget {

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ChangePasswordBloc _changePasswordBloc;
  SharedPreferences prefs;
  String token = "";
  bool streamCheck = false;

  bool _passwordVisible1;
  bool _passwordVisible2;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
  }

  @override
  void initState() {
    _passwordVisible1 = false;
    _passwordVisible2 = false;
    createSharedPref();
    _changePasswordBloc = ChangePasswordBloc();
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
              Container(
                margin: EdgeInsets.only(top: h * 0.1),
                child: Center(
                  child: Text(
                    'Change Password',
                    style: TextStyle(fontSize: w * 0.065, fontWeight: FontWeight.w300, color: Color.fromRGBO(39, 39, 39, 1)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: h * 0.015),
                child: Center(
                  child: Text(
                    'Set your new password',
                    style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.w600, color: Color.fromRGBO(130, 130, 130, 1)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06, top: h * 0.14),
                child: TextFormField(
                  controller: newPasswordController,
                  obscureText: !_passwordVisible1,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter new password";
                    else if (val.length < 8)
                      return "Password required at least 8 character";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.black38),
                    hintText: 'New Password',
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
                        _passwordVisible1
                            ? Icons.visibility
                            : Icons.visibility_off,
                        //color: Theme.of(context).buttonColor,
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
              Container(
                margin: EdgeInsets.only(left: w * 0.06, right: w * 0.06, top: h * 0.02),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !_passwordVisible2,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter confirm password";
                    else if (val.length < 8)
                      return "Password required at least 8 character";
                    else if (val != newPasswordController.text)
                      return "new password and confirm password must match";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.black38),
                    hintText: 'Confirm new Password',
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
                        //color: Theme.of(context).buttonColor,
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
              Container(
                height: h * 0.06,
                margin: EdgeInsets.only(left: w * 0.2, right: w * 0.2, top: h * 0.07),
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
                        "new_password": newPasswordController.text,
                        "confirm_password": confirmPasswordController.text
                      };
                      print(body);
                      streamCheck = true;
                      _changePasswordBloc.changePasswordBlocFunction(body, token);
                    }
                  },
                  child: StreamBuilder<ApiResponse<ChangePasswordModel>>(
                      stream: _changePasswordBloc.changePasswordStream,
                      builder: (context, snapshot) {
                        if (streamCheck) {
                          if (snapshot.hasData) {
                            switch (snapshot.data.status) {

                              case Status.LOADING:
                                return Container(
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
                                if (snapshot.data.data.success == "Password successfully updated") {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.SCALE,
                                        title: 'Success!',
                                        desc: 'Password successfully updated',
                                        btnOkOnPress: () {
                                          Navigator.pop(context);
                                        }).show();
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
                            'Change Password',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w*0.045),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
