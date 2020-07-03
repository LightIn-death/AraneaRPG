import 'package:Aranea/components/description_field.dart';
import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/models/Models.dart';
import 'package:Aranea/views/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (user.sex) Text("Ma") else Text("Fe"),
                        Text(
                          user.pseudo + " . " + user.age.toString(),
                          style:
                              TextStyle(color: kPrimaryDarkColor, fontSize: 30),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(
                          text: "Coins : " + user.coins.toString(),
                          press: () {},
                          width: 0.25,
                          Wpadding: 2,
                          Hpadding: 10,
                          color: kPrimaryColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("AVATAR");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 70.0,
                            child: CircleAvatar(
                              radius: 68.0,
                              backgroundImage:
                                  NetworkImage(kImageUrl + user.image),
                            ),
                          ),
                        ),
                        RoundedButton(
                          text: "Crystals : " + user.crystals.toString(),
                          press: () {},
                          width: 0.25,
                          Wpadding: 2,
                          Hpadding: 10,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Title(color: Colors.black, child: Text("Description")),
                    DescriptionField(
                      text: user.description,
                    ),
                    Divider(),
                    Title(color: Colors.black, child: Text("Meta Description")),
                    DescriptionField(
                      text: user.metadescr,
                    ),
                  ],
                ),
              );
            }
            return Text("Wait");
          }),
    );
  }
}
