import 'dart:io';

import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/models/Models.dart';
import 'package:Aranea/views/welcome_screen/welcome_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:dio/dio.dart' as dio;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  Future<User> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = User.setUser(
        prefs.getInt("Id"),
        prefs.getString("Token"),
        prefs.getString("Pseudo"),
        prefs.getString("Email"),
        prefs.getInt("Age"),
        prefs.getBool("Sex"),
        prefs.getString("Image"),
        prefs.getInt("Coins"),
        prefs.getInt("Crystals"),
        prefs.getString("Description"),
        prefs.getString("Metadescr"));
    return user;
  }

  void uploadImage(User user) async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      String filePath = image.path;
      if (filePath.indexOf('file://') == 0)
        filePath = filePath.split('file://')[1];

      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(filePath, filename: filePath),
        'token': user.token,
        'action': 'upload_profile_pic',
      });

      var dio = Dio();

      var response = new Response(); //Response from Dio
      response = await dio.post(kApiUrl, data: formData);

      var UUID = response.data.toString();

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("Image", UUID.replaceAll('"', ''));
      setState(() {});
    }
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("Id", null);
    prefs.setString("Token", null);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres"),
      ),
      backgroundColor: kSecondaryLightColor,
      body: FutureBuilder(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data;

              var _descriptionController =
                  new TextEditingController(text: user.description);

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    // COL
                    children: [
                      SizedBox(
                        // MARGE
                        height: 50,
                      ),
                      GestureDetector(
                        // IMAGE
                        onTap: () {
                          setState(() {
                            uploadImage(user);
                          });
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(kImageUrl + user.image),
                          radius: 50,
                        ),
                      ),
                      SizedBox(
                        // MARGE
                        height: 25,
                      ),
                      SizedBox(
                        // MARGE
                        height: 20,
                      ),

                      //  ------------------------------ TITRE
                      Divider(),
                      Title(
                        child: Text(
                          "Profile",
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.white,
                      ),
                      Divider(),
                      // --------------------------------------

                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: 100, minWidth: 350),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          color: Colors.white,
                          child: TextField(
                            controller: _descriptionController,
                          ),
                        ),
                      ),

                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: 10, minWidth: 350),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          color: Colors.white,
                          child: (user.sex) ? Text("Ma") : Text("Fe"),
                        ),
                      ),

                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: 10, minWidth: 350),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          color: Colors.white,
                          child: Text(
                            user.pseudo,
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: 10, minWidth: 350),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          color: Colors.white,
                          child: Text(user.age.toString()),
                        ),
                      ),

                      //  ------------------------------ TITRE
                      Divider(),
                      Title(
                        child: Text(
                          "Plus D'informations",
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.white,
                      ),
                      Divider(),
                      // --------------------------------------

                      //  ------------------------------ TITRE
                      Divider(),
                      Title(
                        child: Text(
                          "Compte",
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.white,
                      ),
                      Divider(),
                      // --------------------------------------
                      RoundedButton(
                        // DECONEXION
                        text: "Deconnexion",
                        press: () {},
                        color: Colors.red,
                      ),
                      // MARGE
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          "V 0.1",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(
                        // MARGE
                        height: 50,
                      ),
                    ],
                  ),
                ),
              );
            }
            return CircularProgressIndicator(
              backgroundColor: kPrimaryLightColor,
            );
          }),
    );
  }
}
