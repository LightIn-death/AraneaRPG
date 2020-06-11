import 'package:Aranea/models/Models.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(""),
              radius: 50,
            ),
            Text(""),
            Text(""),
          ],
        ),
      ),
    );
  }
}
