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
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  Future<User> loginUser(String email, String password) async {
    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "login",
      "email": email,
      "password": password,
    });
    var jsonData = json.decode(data.body);
    if (jsonData is String) {
      return null;
    }
    User user = User.fromJson(jsonData);
    print("Conecter :  " + user.pseudo);
    return user;
  }


  void saveUserInfo(User user) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("Id", user.id);
    prefs.setString("Token", user.token);
    prefs.setString("Pseudo", user.pseudo);
    prefs.setString("Email", user.email);
    prefs.setInt("Age", user.age);
    prefs.setBool("Sex", user.sex);
    prefs.setString("Image", user.image);
    prefs.setInt("Coins", user.coins);
    prefs.setInt("Crystals", user.crystals);
    prefs.setString("Description", user.description);
    prefs.setString("Metadescr", user.metadescr);


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

                  saveUserInfo(resp);
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
