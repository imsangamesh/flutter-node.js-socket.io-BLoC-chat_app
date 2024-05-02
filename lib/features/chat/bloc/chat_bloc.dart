import 'package:chat_app/features/chat/models/msg_model.dart';
import 'package:chat_app/features/chat/repos/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required ChatRepo chatRepo})
      : _chatRepo = chatRepo,
        super(const ChatInitial()) {
    on<AddNewMsgEvent>(_onNewMessageAdd);
    on<LoadChatEvent>(_onChatsLoad);
    on<ClearChatEvent>(_onChatsClear);
  }

  final ChatRepo _chatRepo;

  Future<void> _onNewMessageAdd(
    AddNewMsgEvent event,
    Emitter<ChatState> emit,
  ) async {
    final res = await _chatRepo.addNewMessage(event.message);

    res.fold(
      (failure) => emit(ChatFailure(failure.message)),
      (messages) => emit(ChatsLoaded(messages)),
    );
  }

  Future<void> _onChatsLoad(
    LoadChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    final res = await _chatRepo.loadChatMessages();

    res.fold(
      (failure) => emit(ChatFailure(failure.message)),
      (messages) => emit(ChatsLoaded(messages)),
    );
  }

  Future<void> _onChatsClear(
    ClearChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    final res = await _chatRepo.clearChatMessages();

    res.fold(
      (failure) => emit(ChatFailure(failure.message)),
      (messages) => emit(ChatsLoaded(messages)),
    );
  }
}
