import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/chat_repository.dart';
import '../../../models/conversation.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  ChatBloc({
    required this.chatRepository,
  }) : super(ChatInitial()) {
    on<ChatRequested>((event, emit) async {
      try {
        emit(ChatLoadInprogress());
        final chats = await chatRepository.getChats(loginUID: event.currentUid);
        emit(ChatLoadSuccess(chats: chats));
      } on Exception catch (e, trace) {
        log('Issue occrued while loading chats $e $trace ');
        emit(const ChatLoadFailure(message: 'unable to load chats'));
      }
    });
  }
}
