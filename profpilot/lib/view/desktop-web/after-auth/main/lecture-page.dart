import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';


class Msg {
  final String content;
  final String uuid;

  Msg({required this.content, required this.uuid});
}

class ChattingPage extends StatefulWidget {
  final String title;
  final String myUuid;

  ChattingPage({required this.title, required this.myUuid});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  StompClient? stompClient;
  final TextEditingController _textController = TextEditingController();
  final List<Msg> list = [];

  
  final socketUrl = 'http://localhost:8080/chatting';

  void onConnect(StompFrame frame) {
      stompClient!.subscribe(
          destination: '/topic/message',
          callback: (frame) {
              if (frame.body != null) {
                  Map<String, dynamic> obj = json.decode(frame.body!);
                  Msg message = Msg(content: obj['content'], uuid: obj['uuid']);
                  setState(() {
                      list.add(message);
                  });
              }
          },
      );
  }

  void sendMessage() {
      if (_textController.text.isNotEmpty) {
          stompClient!.send(
              destination: '/app/message',
              body: json.encode({"content": _textController.text, "uuid": widget.myUuid}),
          );
          _textController.clear();
      }
  }


  @override
  void initState() {
    super.initState();
    if (stompClient == null) {
      stompClient = StompClient(
        config: StompConfig.sockJS(
          url: socketUrl,
          onConnect: onConnect,
          onWebSocketError: (dynamic error) => print(error.toString()),
        ),
      );
      stompClient!.activate();
    }
  }

  @override
  void dispose() {
    stompClient?.deactivate();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; 
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                color: Colors.grey[200],
              ),
              height: 500,
              width: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      child: Card(
                        
                        child: Container(
                          color: list[position].uuid == widget.myUuid ? Color.fromARGB(255, 234, 250, 9) : Color.fromARGB(255, 0, 0, 0),
                          width: 200,
                          child: Text(
                            list[position].content,
                            textAlign: list[position].uuid == widget.myUuid ? TextAlign.right : TextAlign.left,
                            style: TextStyle(
                              color: list[position].uuid == widget.myUuid ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ),
            Container(
              width: 500,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 50),
                  SizedBox(
                    width: 350,
                    height: 100,
                    child: TextField(
                      controller: _textController,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: "Send Message"),
                    ),
                    
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: sendMessage,
                      child: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
