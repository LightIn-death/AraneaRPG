import 'dart:convert';

import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/models/Models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RandomPage extends StatefulWidget {
  @override
  _RandomState createState() => _RandomState();
}

class _RandomState extends State<RandomPage> {
  Future<User> getRandomProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt("Id");

    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "get_random_account",
      "id": userId.toString(),
    });
    var jsonData = json.decode(data.body);
    if (jsonData is String) {
      return null;
    }
    User user = User.fromJson(jsonData);
    print("Random  :  " + user.pseudo);
    return user;
  }

  Future<User> getRandomSkills($id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt("Id");

    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "get_random_account",
      "id": userId.toString(),
    });
    var jsonData = json.decode(data.body);
    if (jsonData is String) {
      return null;
    }
    User user = User.fromJson(jsonData);
    print("Random  :  " + user.pseudo);
    return user;
  }

  Future<User> launchBattle(int targetId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt("Id");

    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "launch_battle",
      "user": userId.toString(),
      "target": targetId.toString(),
    });
    var jsonData = json.decode(data.body);
    if (jsonData["fail"] is String) {
      return null;
    }
    var winner = jsonData["winner"];
    print("Gagnant  :  " + winner);
    return winner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: FutureBuilder(
          future: getRandomProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (user.sex) Text("Ma") else Text("Fe"),
                        Text(
                          user.pseudo,
                          style:
                              TextStyle(color: kPrimaryDarkColor, fontSize: 30),
                        ),
                        Text(user.age.toString()),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.image),
                      radius: 50,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        child: FittedBox(
                          child: FloatingActionButton(
                            onPressed: () async {
                              print(user.id);
                              Navigator.pop(context);
                              var winner = await launchBattle(user.id);

                              print("After");
                            },
                            child: Image.asset("assets/icons/Aranea_t.png"),
                            backgroundColor: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            }
            return Center(
              //Si Il y a plus de nouveau profile
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No new profile Available"),
                  SizedBox(
                    height: 150,
                  ),
                  RoundedButton(
                    text: "Go back",
                    press: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}
