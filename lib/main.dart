import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:metrotech_education/specialClasses/specialClasses.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/dashboard/dashboard.dart';
import 'package:metrotech_education/myProfile/myProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  userLogin = preferences.getString("access_token") != null ? true : false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Metro Tech Education',
      home: AnimatedSplashScreen(
        splash: Image.asset('images/logo.png'),
        nextScreen: Home(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        duration: 0,
      ),
      routes: <String, WidgetBuilder> {
        '/MyApp': (BuildContext context) => MyApp(),
        '/Home': (BuildContext context) => Home(),
      },

    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    MyHomePage(),
    Dashboard(),
    SpecialClasses(),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/icon_home.png'),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined,),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/icon_special_class.png'),
            ),
            label: 'Special classes',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/icon_account.png'),
            ),
            label: 'Account',
          ),
        ],
        selectedItemColor: Color.fromRGBO(156, 175, 23, 1),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
