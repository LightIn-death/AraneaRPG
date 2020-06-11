import 'dart:async';
import 'dart:convert';

import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/components/rounded_text_input.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/models/Models.dart';
import 'package:Aranea/views/tabs/tabs_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  Future<User> loginUser(String email, String password) async {
    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "login",
      "email": email,
      "password": password,
    });
    var jsonData = json.decode(data.body);
    if (jsonData["fuck"]) {
      return null;
    }
    User user = User.fromJson(jsonData);
    print("Conecter :  " + user.pseudo);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var _emailInput = new TextEditingController();
    var _passwordInput = new TextEditingController();
    return Scaffold(
      backgroundColor: kSecondaryLightColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
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
              controller: _emailInput,
            ),
            RoundedTextInput(
              textHint: "Your Password",
              icon: Icons.vpn_key,
              password: true,
              controller: _passwordInput,
            ),
            SizedBox(height: 30),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                var resp =
                    await loginUser(_emailInput.text, _passwordInput.text);

                if (resp != null) {
                  print("Email = " +
                      _emailInput.text +
                      " et password = " +
                      _passwordInput.text);

                  print("JE suis connecter avec : " + resp.pseudo);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabsContainer(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
