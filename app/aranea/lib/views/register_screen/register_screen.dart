import 'dart:convert';

import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/components/rounded_text_input.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class RegisterScreen extends StatelessWidget {

//
//  Future<http.http.Response> _registerUser(String pseudo, String email,
//      String password, String age, String sex) {
//    return http.post("localhost/araneaRPG" + "/api", headers: <String, String>{
//      'Content-Type': 'application/json;charset=UTF-8'
//    }, body: jsonEncode(<String, String>{'action': 'test'}));
//  }

  @override
  Widget build(BuildContext context) {
    var _emailInput;
    var _passwordInput;
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
              controller:  _emailInput,

            ),
            RoundedTextInput(
              textHint: "Your Password",
              icon: Icons.vpn_key,
              password: true,
              controller: _passwordInput,
            ),
            SizedBox(height: 30),
            RoundedButton(
              text: "REGISTER",
              press: () {





               // _registerUser(, email, password, age, sex)


              },
            )
          ],
        ),
      ),
    );
  }
}
