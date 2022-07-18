import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user.dart';
import '../../bloc/conversation_bloc.dart';
import 'conversation_main_view.dart';

class ConversationView extends StatelessWidget {
  final AppUser loginAppUser;
  final AppUser receiver;
  const ConversationView(
      {Key? key, required this.loginAppUser, required this.receiver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiver.name),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
          // CircleAvatar(
          //   backgroundImage: NetworkImage(receiver.avatar),
          // )
        ],
      ),
      body: Center(
        child: BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            if (state is ConversationLoadSuccess) {
              return ConversationMainView(
                loginAppUser: loginAppUser,
                receiver: receiver,
                conversationId: state.conversation.id ?? '',
              );
            } else if (state is ConversationCreationSuccess) {
              print('thuynga.dt: state is ConversationCreationSuccess');
              return ConversationMainView(
                loginAppUser: loginAppUser,
                receiver: receiver,
                conversationId: state.conversationId,
              );
            } else if (state is ConversationLoadInprogress ||
                state is ConversationCreationInprogress) {
              return const CircularProgressIndicator();
            } else if (state is ConversationLoadFailure ||
                state is ConversationCreationFailure) {
              return const Text(
                  'We are unable to load conversation. Please try again.');
            }
            return Text('Undefined state ${state.runtimeType}');
          },
        ),
      ),
    );
  }
}
