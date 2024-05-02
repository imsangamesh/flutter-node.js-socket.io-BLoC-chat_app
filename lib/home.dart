import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final messages = <Map<String, dynamic>>[];
  final controller = TextEditingController();
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    socket = IO.io(
      'http://192.168.186.210:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket
      ..connect()
      ..onConnect((_) {
        log('Frontend Connected');
        socket.on('sentByServer', listenToMessage);
      });
  }

  void listenToMessage(dynamic data) {
    log(data.toString());
    setState(() {
      messages.add(data as Map<String, dynamic>);
    });
  }

  void sendMessage() {
    final messageJson = {
      'msg': controller.text.trim(),
      'sentBy': socket.id,
    };
    socket.emit('sendMessage', messageJson);
    setState(() {
      messages.add(messageJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    return Text(
                      '${messages[i]['msg']} - ${messages[i]['sentBy']}',
                      style: const TextStyle(fontSize: 18),
                    );
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: sendMessage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
