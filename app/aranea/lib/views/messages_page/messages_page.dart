import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:Aranea/components/rounded_button.dart';
import 'package:Aranea/components/rounded_text_input.dart';
import 'package:Aranea/constants.dart';
import 'package:Aranea/models/Models.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MessagePage extends StatefulWidget {
  final User otherUser;
  final Conv conv;

  const MessagePage({Key key, this.otherUser, this.conv}) : super(key: key);

  @override
  _MessageState createState() => _MessageState(conv, otherUser);
}

class _MessageState extends State<MessagePage> {
  final Conv conv;
  final User otherUser;

  _MessageState(this.conv, this.otherUser);

  var _messagesListController = new ScrollController();

//  async* {
//  yield await getMessages(convId);
//  }

  Stream<List<Message>> messageFlow(String convId) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 200));
      yield await getMessages(convId);
//      Stream.fromFuture(getMessages(convId));
    }
  }

  Future<List<Message>> getMessages(String convId) async {
    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "get_messages",
      "convId": convId,
    });
    var jsonData = json.decode(data.body);

    List<Message> messages = [];
    for (var m in jsonData) {
      Message message = Message.fromJson(m);
      messages.add(message);
    }
    return messages;
  }

  Future<void> sendMessage(String convId, String content) async {
    if (content.length == 0) {
      return null;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var owner = prefs.getInt("Id");

    var data = await http
        .post(kApiUrl, headers: <String, String>{}, body: <String, String>{
      "action": "send_message",
      "convId": convId,
      "content": content,
      "owner": owner.toString(),
    });
  }

  _buildMessageComposer(Conv conv) {
    var _messageInput = new TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: kPrimaryLightColor,
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25.0,
              color: kPrimaryColor,
              onPressed: null),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (value) {
                sendMessage(conv.id, value);
                _messageInput.text = "";
              },
              controller: _messageInput,
              decoration:
                  InputDecoration.collapsed(hintText: "Send a message..."),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: kPrimaryColor,
              onPressed: () {
                sendMessage(conv.id, _messageInput.text);
                _messageInput.text = "";
              }),
        ],
      ),
    );
  }

  _buildMessage(Message message, bool isMe) {
    return Container(
      decoration: BoxDecoration(
        color: isMe ? kSecondaryColor : kSecondaryLightColor,
        borderRadius: BorderRadius.circular(3),
      ),
      margin: isMe
          ? EdgeInsets.only(top: 4.0, bottom: 4.0, left: 90.0)
          : EdgeInsets.only(top: 4.0, bottom: 4.0, right: 90.0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text(
        message.content,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(otherUser.image),
            ),
            Text(otherUser.pseudo),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: messageFlow(conv.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text('Loading'),
                      ),
                    );
                  }
                  return ListView.builder(
                      reverse: true,
                      controller: _messagesListController,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Message message = snapshot.data[index];
                        var isMe = message.owner == otherUser.id ? false : true;
                        return _buildMessage(message, isMe);
                      });
                }),
          ),
          _buildMessageComposer(conv),
        ],
      ),
    );
  }
}
