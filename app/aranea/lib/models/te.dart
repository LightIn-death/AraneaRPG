import 'package:Aranea/models/Models.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {

  final Conv conv;
  final User otherUser;

  const Test({Key key, this.conv, this.otherUser}) : super(key: key);



  Stream<List<Message>> messageFlow(String convId) {
    return Stream.fromFuture(getMessages(convId));
  }

  Future<List<Message>> getMessages(String convId) async {
    var data = await http
        .post(MyApiUrl, headers: <String, String>{}, body: <String, String>{
      "someParam": "param",
      "id": convId,
    });
    var jsonData = json.decode(data.body);

    List<Message> messages = [];
    for (var m in jsonData) {
      Message message = Message.fromJson(m);
      messages.add(message);
    }
    return messages;
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
        });
  }
}





