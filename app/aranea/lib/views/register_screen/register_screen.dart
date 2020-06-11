import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/components/rounded_text_input.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryLightColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
              style: TextStyle(fontSize: 40, color: kPrimaryDarkColor),
            ),
            Text(
              'Get Into The Web',
              style: TextStyle(fontSize: 30, color: kPrimaryColor),
            ),
            SizedBox(height: 100),
            RoundedTextInput(
              textHint: "Your Email",
              icon: Icons.person,
              onChanged: (value) {},
            ),
            RoundedTextInput(
              textHint: "Your Password",
              icon: Icons.vpn_key,
              password: true,
            ),
            SizedBox(height: 30),
            RoundedButton(
              text: "REGISTER",
              press: () {},
            )
          ],
        ),
      ),
    );
  }
}
