import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/message_repository.dart';
import '../../../models/message.dart';

part 'message_receiver_event.dart';
part 'message_receiver_state.dart';

class MessageReceiverBloc
    extends Bloc<MessageReceiverEvent, MessageReceiverState> {
  final MessageRepository messageRepository;
  late final StreamSubscription? messageStream;

  MessageReceiverBloc({
    required this.messageRepository,
  }) : super(MessageReceiverInitial()) {
    on<MessageRequested>((event, emit) {
      try {
        emit(MessageLoadInprogress());
        messageStream = messageRepository
            .getMessages(conversationId: event.conversationId)
            .listen((messages) {
          add(MessageReceived(messages: messages));
        });
      } on Exception catch (e, trace) {
        log('Issue while loading message $e $trace');
        emit(MessageLoadFailure(message: e.toString()));
      }
    });
    on<MessageReceived>((event, emit) {
      emit(MessageLoadSuccess(messages: event.messages));
    });
  }

  @override
  Future<void> close() {
    messageStream?.cancel();
    return super.close();
  }
}
