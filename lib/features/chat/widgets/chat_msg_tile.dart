import 'package:chat_app/core/constants/app_text_styles.dart';
import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/services/injection_container.dart';
import 'package:chat_app/core/theme/cubit/theme_cubit.dart';
import 'package:chat_app/features/chat/models/msg_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatMsgTile extends StatelessWidget {
  const ChatMsgTile(this.message, {super.key});

  final MsgModel message;

  bool get isMyMsg => slAuth.user!.id == message.userId;

  Color get tileColor =>
      isMyMsg ? AppColors.listTile : AppColors.listTile.withAlpha(70);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          margin:
              EdgeInsets.fromLTRB(isMyMsg ? 50 : 0, 0, !isMyMsg ? 50 : 0, 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tileColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------- MESSAGE
              Text(message.msg, style: AppTStyles.body),

              // ---------------------- SENDER NAME | DATE & TIME
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.fromLTRB(7, 3, 8, 3),
                  decoration: BoxDecoration(
                    color: AppColors.scaffold,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(7),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name
                      Container(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: Text(
                          message.sentBy,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Date & Time
                      Text(
                        '  •  ${DateFormat('MMM dd | HH:mm').format(message.date)}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
