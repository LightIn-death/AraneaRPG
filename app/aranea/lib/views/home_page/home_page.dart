import 'dart:convert';
import 'dart:ui';

import 'package:Aranea/components/skillsDetails.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/models/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kSecondaryLightColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkillsDetails(),
            Column(
              children: [
                Center(
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: Image.asset("assets/icons/Aranea_t.png"),
                        backgroundColor: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ));
  }
}
