import 'package:Aranea/models/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DescriptionField extends StatelessWidget {
  final String text;

  const DescriptionField({
    Key key,
    this.text,
//    @required this.toShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 100, minWidth: 350),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        color: Colors.white,
        child: (text != null) ? Text(text) : Text("Pas de description.."),
      ),
    );
  }
}
