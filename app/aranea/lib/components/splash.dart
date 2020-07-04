import 'dart:async';
import 'dart:ffi';

import 'package:Aranea/constants.dart';
import 'package:Aranea/views/login_screen/login_screen.dart';
import 'package:Aranea/views/tabs/tabs_container.dart';
import 'package:Aranea/views/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isAuth = false;

  void autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final alreadyAuth = prefs.getInt("Id");
    print("Welllcome, Id : " + alreadyAuth.toString());
    if (alreadyAuth != null) {
      isAuth = true;
    }
  }

  double _height = 80;

  @override
  void initState() {
    super.initState();
    _height = 180;
    autoLogin();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => isAuth ? TabsContainer() : WelcomeScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          height: _height,
          child: Image.asset("assets/icons/ic_launcher.png"),
        ),
      ),
    );
  }
}
