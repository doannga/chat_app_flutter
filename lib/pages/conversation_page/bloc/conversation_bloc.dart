import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/conversation_repository.dart';
import '../../../models/conversation.dart';
import '../../../models/user.dart';


part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository conversationRepository;
  ConversationBloc({
    required this.conversationRepository,
  }) : super(ConversationInitial()) {
    on<ConversationDetailRequested>((event, emit) async {
      try {
        emit(ConversationLoadInprogress());
        final conversationDetail = await conversationRepository.getConversation(
          senderUID: event.loginAppUser.uid,
          receiverUID: event.receiver.uid,
        );

        if (conversationDetail != null) {
          emit(ConversationLoadSuccess(conversation: conversationDetail));
        } else {
          add(
            ConversationCreated(
              conversation: Conversation(
                creator: event.loginAppUser,
                receiver: event.receiver,
                members: [event.loginAppUser.uid, event.receiver.uid],
              ),
            ),
          );
        }
      } catch (e, stackTrace) {
        log('Issue whiel fetching covnersation detail ${e.toString()}');
        log('Stack trace is ${stackTrace.toString()}');
        emit(
          const ConversationLoadFailure(message: 'Unable to load Conversation'),
        );
      }
    });
    on<ConversationCreated>((event, emit) async {
      try {
        emit(ConversationCreationInprogress());

        final conversationId = await conversationRepository.createConversation(
          conversation: event.conversation,
        );
        emit(ConversationCreationSuccess(conversationId: conversationId));
      } catch (e) {
        log('Issue occured while creating conversation ${e.toString()}');
        emit(
          ConversationCreationFailure(
            message: 'Unable to create new conversation ${e.toString()}',
          ),
        );
      }
    });
  }
}
