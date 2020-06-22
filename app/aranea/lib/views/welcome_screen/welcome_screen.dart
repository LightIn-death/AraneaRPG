import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/views/login_screen/login_screen.dart';
import 'package:Aranea/views/register_screen/register_screen.dart';
import 'package:Aranea/views/tabs/tabs_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryLightColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aranea",
              style: TextStyle(fontSize: 40, color: kPrimaryDarkColor),
            ),
            Text(
              "Get Into The Web",
              style: TextStyle(fontSize: 30, color: kPrimaryLightColor),
            ),
            SizedBox(height: 100),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
            ),
            SizedBox(height: 40),
            RoundedButton(
              text: "REGISTER",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return RegisterScreen();
                  }),
                );
              },
              color: kPrimaryLightColor,
              textColor: kPrimaryDarkColor,
            ),
          ],
        ),
      ),
    );
  }
}
