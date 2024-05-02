import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/core/services/typedefs.dart';
import 'package:chat_app/features/chat/models/msg_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

class ChatRepo {
  ChatRepo({required HiveInterface hive}) : _hive = hive;

  final HiveInterface _hive;

  Box<MsgModel> get msgBox => _hive.box<MsgModel>(BoxKeys.messages);

  FutureEither<List<MsgModel>> addNewMessage(MsgModel message) async {
    try {
      await msgBox.add(message);
      return right(msgBox.values.toList());
    } catch (e) {
      return left(ApiFailure(e.toString()));
    }
  }

  FutureEither<List<MsgModel>> loadChatMessages() async {
    try {
      return right(msgBox.values.toList());
    } catch (e) {
      return left(ApiFailure(e.toString()));
    }
  }

  FutureEither<List<MsgModel>> clearChatMessages() async {
    try {
      if (await _hive.boxExists(BoxKeys.messages)) {
        await msgBox.deleteFromDisk();
        await _hive.openBox<MsgModel>(BoxKeys.messages);
      }
      return right([]);
    } catch (e) {
      return left(ApiFailure(e.toString()));
    }
  }
}
