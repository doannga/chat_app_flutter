part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class ConversationDetailRequested extends ConversationEvent {
  final AppUser loginAppUser;
  final AppUser receiver;
  const ConversationDetailRequested({
    required this.loginAppUser,
    required this.receiver,
  });
}

class ConversationCreated extends ConversationEvent {
  final Conversation conversation;
  const ConversationCreated({
    required this.conversation,
  });
}
