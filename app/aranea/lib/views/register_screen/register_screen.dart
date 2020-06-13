import 'dart:convert';

import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/components/rounded_text_input.dart';
import 'package:Aranea/models/Models.dart';
import 'package:Aranea/views/tabs/tabs_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {


  var _remailInput = new TextEditingController();
  var _rpasswordInput = new TextEditingController();
  var _usernameInput = new TextEditingController();
  var _ageInput = new TextEditingController();

  int currentStep = 0;
  bool complete = false;

  nextStep() {
    currentStep + 1 != 3
        ? goToStep(currentStep + 1)
        : setState(() => complete = true);
  }

  previousStep() {
    currentStep - 1 != -1
        ? goToStep(currentStep - 1)
        : setState(() => complete = true);
  }

  goToStep(int step) {
    setState(() {
      currentStep = step;
    });
  }

  String dropdownValue = 'm';

  Future<User> registerUser(String pseudo, String email, String password,
      String age, String sex) async {
    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "register",
      "pseudo": pseudo,
      "email": email,
      "password": password,
      "age": age,
      "sex": sex,
    });
    var jsonData = json.decode(data.body);
    if (jsonData is String) {
      return null;
    }
    User user = User.fromJson(jsonData);
    print("Register :  " + user.pseudo);
    return user;
  }

  void saveUserInfo(User user) async {
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
    return Scaffold(
      backgroundColor: kSecondaryLightColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Register',
              style: TextStyle(fontSize: 35, color: kPrimaryDarkColor),
            ),
            Text(
              'Get Into The Web',
              style: TextStyle(fontSize: 25, color: kPrimaryColor),
            ),
            Expanded(
              child: Stepper(
                  type: StepperType.vertical,
                  currentStep: currentStep,
                  onStepContinue: nextStep,
                  onStepCancel: previousStep,
                  onStepTapped: goToStep,
                  steps: [
                    Step(
                        isActive: true,
                        title: Text("Authentication Information"),
                        state: StepState.indexed,
                        content: Column(
                          children: [
                            RoundedTextInput(
                              textHint: "Your Email",
                              icon: Icons.person,
                              onChanged: (value) {},
                              controller: _remailInput,
                            ),
                            RoundedTextInput(
                              textHint: "Your Password",
                              icon: Icons.vpn_key,
                              password: true,
                              controller: _rpasswordInput,
                            ),
                          ],
                        )),
                    Step(
                        state: StepState.editing,
                        isActive: true,
                        title: Text("Basic Information"),
                        content: Column(
                          children: [
                            RoundedTextInput(
                              textHint: "Your Username",
                              icon: Icons.person,
                              onChanged: (value) {},
                              controller: _usernameInput,
                            ),
                            RoundedTextInput(
                              textHint: "Your Age",
                              icon: Icons.person,
                              onChanged: (value) {},
                              controller: _ageInput,
                            ),
                            DropdownButton<String>(
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_back),
                                iconSize: 24,
                                elevation: 1,
                                style: TextStyle(color: kPrimaryDarkColor),
                                underline: Container(
                                  height: 2,
                                  color: kPrimaryColor,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "m",
                                    child: Text("Male"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "f",
                                    child: Text("Female"),
                                  ),
                                ]),
                          ],
                        )),
                    Step(
                        state: StepState.complete,
                        isActive: true,
                        title: Text("Validation"),
                        content: Column(
                          children: [
                            RoundedButton(
                              text: "REGISTER",
                              press: () async {
                                var _sex =
                                    dropdownValue == "m" ? "true" : "false";

                                var newUser = await registerUser(
                                    _usernameInput.text,
                                    _remailInput.text,
                                    _rpasswordInput.text,
                                    _ageInput.text,
                                    _sex);
                                if (newUser is String) {
                                  return null;
                                }

                                saveUserInfo(newUser);

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TabsContainer(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );

                                // _registerUser(, email, password, age, sex)
                              },
                            )
                          ],
                        )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
