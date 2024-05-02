import 'dart:developer';

import 'package:chat_app/core/common/buttons.dart';
import 'package:chat_app/core/common/util_widgets.dart';
import 'package:chat_app/core/common/widgets/app_textfield.dart';
import 'package:chat_app/core/services/injection_container.dart';
import 'package:chat_app/core/services/typedefs.dart';
import 'package:chat_app/core/utils/nav_utils.dart';
import 'package:chat_app/core/utils/utils.dart';
import 'package:chat_app/features/auth/screens/profile_screen.dart';
import 'package:chat_app/features/chat/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/models/msg_model.dart';
import 'package:chat_app/features/chat/widgets/chat_msg_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

const url = 'http://192.168.186.210:3000';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //
  final msgCntr = TextEditingController(text: 'Hello there!');
  late Socket socket;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(const LoadChatEvent());
    initiateSocket();
  }

  /// - - - - - - - - - - - - - - - - - - - `INITIATE SOCKET`
  void initiateSocket() {
    socket = io(
      url,
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );

    socket
      ..connect()
      ..onConnect((_) {
        log('Frontend Connected');

        // Listening to messages `sender`
        socket.on('chat_room', (data) {
          log(data.toString());
          final newMsg = MsgModel.fromMap(data as DataMap);

          // Only adding message if it's not mine
          if (newMsg.userId != slAuth.user!.id) {
            context.read<ChatBloc>().add(AddNewMsgEvent(newMsg));
          }
        });
      });
  }

  /// - - - - - - - - - - - - - - - - - - - `SEND MESSAGE`
  void sendMessage() {
    final user = slAuth.user!;
    final message = MsgModel(
      userId: user.id,
      sentBy: user.name,
      msg: msgCntr.text.trim(),
      date: DateTime.now(),
    );

    socket.emit('chat_room', message.toMap());
    context.read<ChatBloc>().add(AddNewMsgEvent(message));
    msgCntr.clear();
  }

  /// - - - - - - - - - - - - - - - - - - - `CLEAR CHAT HISTORY`
  void showClearChatDialog() {
    AppDialog.show(
      context,
      title: 'Clear Chat?',
      content: 'Are you sure that you want to clear the ongoing chat? '
          'This process is irreversible!',
      actions: [
        ElevatedBtn('No', () => NavUtils.back(context)),
        OutlinedBtn(
          'Yes',
          () {
            context.read<ChatBloc>().add(const ClearChatEvent());
            NavUtils.back(context);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatFailure) {
          AppSnackbar.error(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Chat Room'),
            actions: [
              if (state is ChatsLoaded && state.messages.isNotEmpty)
                IconButton(
                  onPressed: showClearChatDialog,
                  icon: const Icon(Icons.clear_all, size: 28),
                ),
              IconButton(
                onPressed: () => NavUtils.to(context, const ProfileScreen()),
                icon: const Icon(Icons.person_4_rounded),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is ChatsLoaded) {
                        // - - - - - - - - - - - - EMPTY LIST
                        if (state.messages.isEmpty) {
                          return const EmptyList(
                            'No messages yet! Be the first to send',
                          );
                        }
                        // - - - - - - - - - - - - MESSAGES LIST
                        return ListView.builder(
                          itemCount: state.messages.length,
                          itemBuilder: (context, i) {
                            return ChatMsgTile(state.messages[i]);
                          },
                        );
                      } else if (state is ChatFailure) {
                        // - - - - - - - - - - - - ERROR
                        return Center(child: Text(state.message));
                      } else {
                        // - - - - - - - - - - - - LOADER
                        return const Loader();
                      }
                    },
                  ),
                ),

                // - - - - - - - - `MESSAGE TEXTFIELD`
                AppTextField(
                  msgCntr,
                  'Your message',
                  maxLines: null,
                  bottomPadding: 3,
                  suffixFun: msgCntr.text.isEmpty ? null : sendMessage,
                  suffixIcon: Icons.send_rounded,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
