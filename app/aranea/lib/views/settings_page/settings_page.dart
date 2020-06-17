import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/models/Models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: FutureBuilder(
            future: getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                User user = snapshot.data;
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var image = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            if (image != null) {}
                            var stream = new http.ByteStream(
                                DelegatingStream.typed(image.openRead()));
//                          var length = await image.
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.image),
                            radius: 50,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (user.sex) Text("Ma") else Text("Fe"),
                            Text(
                              user.pseudo,
                              style: TextStyle(
                                  color: kPrimaryDarkColor, fontSize: 30),
                            ),
                            Text(user.age.toString()),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (user.description != null)
                          Text(user.description)
                        else
                          Text("Pas de description.."),
                        SizedBox(
                          height: 50,
                        ),
                        if (user.metadescr != null)
                          Text(user.metadescr)
                        else
                          Text("Pas de Meta description.."),
                        SizedBox(
                          height: 450,
                        ),
                        RoundedButton(
                          text: "Deconnexion",
                          press: () {},
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                );
              }
              return Text("Wait");
            }));
  }
}
