import 'package:Aranea/models/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        child: (user.description != null)
            ? Text(user.description)
            : Text("Pas de description.."),
      ),
    );
  }
}
