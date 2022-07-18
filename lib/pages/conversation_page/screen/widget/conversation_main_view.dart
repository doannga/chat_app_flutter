import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/provider/message_firebase_provider.dart';
import '../../../../data/repositories/message_repository.dart';
import '../../../../models/user.dart';
import '../../bloc/message_receiver_bloc.dart';
import '../../bloc/message_sender_bloc.dart';
import 'conversation_message_view_widget.dart';
import 'conversation_sender_view.dart';

class ConversationMainView extends StatelessWidget {
  final AppUser loginAppUser;
  final AppUser receiver;
  final String conversationId;

  const ConversationMainView({
    Key? key,
    required this.loginAppUser,
    required this.receiver,
    required this.conversationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const heightOfContainer = 50;
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              heightOfContainer -
              15,
          child: BlocProvider(
            create: (context) => MessageReceiverBloc(
              messageRepository: MessageRepository(
                messageFirebaseProvider: MessageFirebaseProvider(
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            )..add(MessageRequested(conversationId: conversationId)),
            child: ConversationMessageView(
              receiver: receiver,
              loginAppUser: loginAppUser,
            ),
          ),
        ),
        Container(
          height: heightOfContainer.toDouble(),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: BlocProvider(
              create: (context) => MessageSenderBloc(
                MessageRepository(
                  messageFirebaseProvider: MessageFirebaseProvider(
                    firestore: FirebaseFirestore.instance,
                  ),
                ),
              ),
              child: ConversationSenderView(
                conversationId: conversationId,
                senderUID: loginAppUser.uid,
                receiverUID: receiver.uid,
              ),
            ),
          ),
        )
      ],
    );
  }
}
