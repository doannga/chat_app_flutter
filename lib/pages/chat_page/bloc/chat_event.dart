part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatRequested extends ChatEvent {
  final String currentUid;
  const ChatRequested({
    required this.currentUid,
    loginUID,
  });
  @override
  List<Object> get props => [currentUid];
}
