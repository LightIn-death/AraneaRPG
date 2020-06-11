import 'dart:ui';

import 'package:Aranea/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryLightColor,
      body: Center(
        child: Container(
          height: 200.0,
          width: 200.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              child: Image.asset("assets/icons/Aranea_t.png"),
              backgroundColor: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
