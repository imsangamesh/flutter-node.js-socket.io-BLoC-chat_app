part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {
  const ChatInitial();
}

final class ChatsLoaded extends ChatState {
  const ChatsLoaded(this.messages);
  final List<MsgModel> messages;
}

final class ChatFailure extends ChatState {
  const ChatFailure(this.message);
  final String message;
}
