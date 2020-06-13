import 'package:Aranea/models/Models.dart';
import 'package:Aranea/views/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class InboxPage extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<InboxPage> {
  Future<List<Conv>> _getUser() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/bQWLUGNLvS?indent=2");
    var jsonData = json.decode(data.body);
    List<Conv> convs = [];
    for (var c in jsonData) {
      Conv conv =
          Conv(c["index"], c["about"], c["name"], c["email"], c["picture"]);
      convs.add(conv);
    }
    print("Nombre d'object recuperer :  " + convs.length.toString());
    return convs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: _getUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading'),
                  ),
                );
              }

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[index].picture),
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                    );
                  });
            }));
  }
}
