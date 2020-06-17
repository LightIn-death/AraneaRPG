import 'package:Aranea/models/Models.dart';
import 'package:Aranea/views/messages_page/messages_page.dart';
import 'package:Aranea/views/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<InboxPage> {
  Future<List<Conv>> _getConvs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("Token");

    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "get_convs",
      "token": token,
    });
    var jsonData = json.decode(data.body);
    List<Conv> convs = [];
    for (var c in jsonData) {
      Conv conv = Conv.fromJson(c);
      convs.add(conv);
    }
    return convs;
  }

  Future<User> _getConvsUser(Conv conv) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("Id");
    print("MY ID : " + id.toString());
    var otherId = id == conv.winner ? conv.looser : conv.winner;
    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "get_profile",
      "id": otherId.toString(),
    });
    var jsonData = json.decode(data.body);
    User user = User.fromJson(jsonData);
    print("other :" + user.pseudo);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: _getConvs(),
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
                    Conv conv = snapshot.data[index];
                    return FutureBuilder(
                      future: _getConvsUser(conv),
                      builder: (context, snapshot2) {
                        if (snapshot2.hasData) {
                          print("chargement 3");
                          User other = snapshot2.data;
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(other.image),
                            ),
                            title: Text(other.pseudo),
                            subtitle: Text(conv.lastmessage),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => MessagePage(
                                            conv: conv,
                                            otherUser: other,
                                          )));
                            },
                          );
                        }
                        return ListTile(
                          title: Text(conv.id),
                          subtitle: Text(conv.winner.toString()),
                          onTap: () {},
                        );
                      },
                    );
                  });
            }));
  }
}
