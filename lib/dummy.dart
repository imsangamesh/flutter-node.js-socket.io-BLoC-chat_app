// import 'dart:developer';

// import 'package:chat_app/core/common/widgets/app_textfield.dart';
// import 'package:chat_app/core/services/injection_container.dart';
// import 'package:chat_app/core/services/typedefs.dart';
// import 'package:chat_app/core/utils/nav_utils.dart';
// import 'package:chat_app/features/auth/screens/profile_screen.dart';
// import 'package:chat_app/features/chat/models/msg_model.dart';
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// const url = 'http://192.168.186.210:3000';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   //
//   final msgCntr = TextEditingController(text: 'Hello there!');
//   final messages = <MsgModel>[];
//   late io.Socket socket;

//   @override
//   void initState() {
//     super.initState();
//     initiateSocket();
//   }

//   void initiateSocket() {
//     socket = io.io(
//       url,
//       io.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .build(),
//     );

//     socket
//       ..connect()
//       ..onConnect((_) {
//         log('Frontend Connected');

//         // Listening to messages
//         socket.on('chat_room', (data) {
//           log(data.toString());
//           setState(() {
//             messages.add(MsgModel.fromMap(data as DataMap));
//           });
//         });
//       });
//   }

//   void sendMessage() {
//     final name = slAuth.user!.name;
//     final message = MsgModel(
//       sentBy: name,
//       msg: msgCntr.text.trim(),
//       date: DateTime.now(),
//     );

//     socket.emit('chat_room', message.toMap());
//     setState(() {
//       messages.add(message);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat Room'),
//         actions: [
//           IconButton(
//             onPressed: initiateSocket,
//             icon: const Icon(Icons.refresh),
//           ),
//           IconButton(
//             onPressed: () => NavUtils.to(context, const ProfileScreen()),
//             icon: const Icon(Icons.person_4_rounded),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: messages.length,
//                 itemBuilder: (context, i) {
//                   return Text(messages[i].toString());
//                 },
//               ),
//             ),
//             AppTextField(
//               msgCntr,
//               'Your message',
//               bottomPadding: 0,
//               suffixFun: sendMessage,
//               suffixIcon: Icons.send_rounded,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
