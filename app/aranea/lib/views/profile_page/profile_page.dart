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
              return Center(
                child: Column(
                  children: [
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
                        Text("Coins : " + user.coins.toString()),
                        GestureDetector(
                          onTap: () {
                            print("AVATAR");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.image),
                            radius: 60,
                            backgroundColor: kPrimaryColor,
                          ),
                        ),
                        Text("Crystals : " + user.crystals.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DescriptionField(user: user),
                    SizedBox(
                      height: 50,
                    ),
                    if (user.metadescr != null)
                      Text(user.metadescr)
                    else
                      Text("Pas de Meta description.."),
                  ],
                ),
              );
            }
            return Text("Wait");
          }),
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 25),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: Colors.white,
        child: Text(user.description),
      ),
    );
  }
}
