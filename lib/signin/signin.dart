import 'package:flutter/material.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/forgotPassword/forgotPassword.dart';
import 'package:metrotech_education/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/signinBloc.dart';
import 'model/signinlModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SigninBloc _signinbloc;
  SharedPreferences prefs;
  bool _passwordVisible1;
  bool streamCheck = false;

  @override
  void initState() {
    _passwordVisible1 = false;
    _signinbloc = SigninBloc();
    super.initState();
  }

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
              SizedBox(height: h * 0.07),
              Container(
                child: Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(
                        fontSize: w * 0.08,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(39, 39, 39, 1)),
                  ),
                ),
              ),
              SizedBox(height: h * 0.01),
              Container(
                child: Center(
                  child: Text(
                    'Hey! Good to see you again.',
                    style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(77, 200, 174, 1)),
                  ),
                ),
              ),
              SizedBox(height: h * 0.08),
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
              SizedBox(height: h * 0.02),
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
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontSize: w * 0.035,
                    ),
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
                margin: EdgeInsets.only(right: w * 0.06, top: h * 0.015),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: w * 0.035,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.055),
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
                        "email": emailController.text,
                        "password": passwordController.text,
                      };
                      print(body);
                      streamCheck = true;
                      _signinbloc.Signin(body);
                    }
                  },
                  child: StreamBuilder<ApiResponse<SigninModel>>(
                      stream: _signinbloc.signinStream,
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
                                userLogin = true;
                                Future.delayed(Duration.zero, () async {
                                  prefs = await SharedPreferences.getInstance();
                                  prefs.setString('access_token', snapshot.data.data.accessToken);
                                  prefs.setString('student_picture', snapshot.data.data.data[0].profilePic);
                                  prefs.setString('student_name', snapshot.data.data.data[0].fullname);
                                });

                                if (snapshot.data.data.accessToken != null) {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.SCALE,
                                        title: 'Success!',
                                        desc: 'You have login successfully',
                                        btnOkOnPress: () {
                                          Navigator.of(context).pushNamedAndRemoveUntil('/Home', ModalRoute.withName('/MyApp'));
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
                                        desc: 'Please check your email id and password and try again!',
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
                            'Login',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: h * 0.2),
              Container(
                margin: EdgeInsets.only(left: w * 0.3, right: w * 0.3),
                child: Row(
                  children: [
                    Text(
                      'New here? ',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: w * 0.037,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup())),
                      },
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                            color: Color.fromRGBO(77, 200, 174, 1),
                            fontSize: w * 0.035,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
