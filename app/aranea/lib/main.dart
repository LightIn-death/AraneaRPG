import 'package:Aranea/components/splash.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/views/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aranea',
      theme: ThemeData(
          backgroundColor: kSecondaryLightColor,
          accentColor: kPrimaryDarkColor,
          dividerTheme: DividerThemeData(
            color: kPrimaryDarkColor,
          ),
          splashColor: kSecondaryLightColor,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kSecondaryLightColor,
          fontFamily: "Montserrat"),
      home: Splash(),
    );
  }
}
