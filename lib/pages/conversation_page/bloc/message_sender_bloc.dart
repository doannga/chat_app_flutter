import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/message_repository.dart';
import '../../../models/message.dart';

part 'message_sender_event.dart';
part 'message_sender_state.dart';

class MessageSenderBloc extends Bloc<MessageSenderEvent, MessageSenderState> {
  final MessageRepository messageRepository;

  MessageSenderBloc(
    this.messageRepository,
  ) : super(MessageInitial()) {
    on<MessageSent>((event, emit) async {
      try {
        emit(MessageSentInprogress());
        await messageRepository.sendMessage(message: event.message);
        emit(MessageSentSuccess());
      } on Exception catch (e, stackTrace) {
        log('Issue while sending message ${e.toString()} $stackTrace');
        emit(MessageSentFailure(message: e.toString()));
      }
    });
  }
}
