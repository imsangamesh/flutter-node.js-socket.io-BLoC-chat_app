part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {
  const ChatEvent();
}

final class LoadChatEvent extends ChatEvent {
  const LoadChatEvent();
}

final class AddNewMsgEvent extends ChatEvent {
  const AddNewMsgEvent(this.message);
  final MsgModel message;
}

final class ClearChatEvent extends ChatEvent {
  const ClearChatEvent();
}
