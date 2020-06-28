import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/models/Models.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SkillsDetails extends StatefulWidget {
  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<SkillsDetails> {
  Future<dynamic> addPoint(String categorie) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString("Token");

    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "add_skill_point",
      "token": userToken,
      "categ": categorie,
    });
    setState(() {});
  }

  Future<Skills> getSkills() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt("Id").toString();

    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "get_skills",
      "id": userId,
    });
    var jsonData = json.decode(data.body);
    if (jsonData is String) {
      return null;
    }
    Skills skills = Skills.fromJson(jsonData);
    print("free :  " + skills.free.toString());
    return skills;
  }

  @override
  Widget build(BuildContext context) {
    print("Update");
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getSkills(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Skills skills = snapshot.data;

          var _free = skills.free > 0 ? true : false;
          return Column(
            children: [
              Text("Your Skills : "),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    SkillLine(
                      text: "Strength",
                      skill: skills.strength.toString(),
                      free: _free,
                      func: () {
                        addPoint("str");
                      },
                    ),
                    SkillLine(
                      text: "Intelligence",
                      skill: skills.intelligence.toString(),
                      free: _free,
                      func: () {
                        addPoint("int");
                      },
                    ),
                    SkillLine(
                      text: "Magie",
                      skill: skills.magie.toString(),
                      free: _free,
                      func: () {
                        addPoint("mag");
                      },
                    ),
                    SkillLine(
                      text: "Speed",
                      skill: skills.speed.toString(),
                      free: _free,
                      func: () {
                        addPoint("spd");
                      },
                    ),
                    SkillLine(
                      text: "Charisme",
                      skill: skills.charisme.toString(),
                      free: _free,
                      func: () {
                        addPoint("char");
                      },
                    ),
                    if (skills.free == 0)
                      Text(
                        "You don't have skill point ",
                      )
                  ],
                ),
              ),
              if (skills.free > 0)
                SkillLine(
                  free: false,
                  text: "Point Left",
                  skill: skills.free.toString(),
                  width: 0.4,
                )
            ],
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 60,
            ),
            CircularProgressIndicator(
              backgroundColor: kPrimaryLightColor,
            ),
          ],
        );
      },
    );
  }
}

class SkillLine extends StatelessWidget {
  final String text;
  final String skill;
  final bool free;

  final double width;
  final Function func;

  const SkillLine(
      {Key key, this.text, this.skill, this.free, this.width = 0.8, this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * width,
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(skill),
          if (free) FlatButton(onPressed: func, child: Text("+"))
        ],
      ),
    );
  }
}
