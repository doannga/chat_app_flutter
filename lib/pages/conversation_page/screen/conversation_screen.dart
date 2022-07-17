import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/pages/conversation_page/screen/widget/conversation_view_widget.dart';

import '../../../data/provider/conversation_firebase_provider.dart';
import '../../../data/repositories/conversation_repository.dart';
import '../../../models/user.dart';
import '../bloc/conversation_bloc.dart';

class ConversationScreen extends StatelessWidget {
  final String? converasationId;
  final AppUser sender;
  final AppUser receiver;
  const ConversationScreen(
      {Key? key,
      this.converasationId,
      required this.sender,
      required this.receiver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationBloc(
        conversationRepository: ConversationRepository(
          conversationFirebaseProvider: ConversationFirebaseProvider(
            firestore: FirebaseFirestore.instance,
          ),
        ),
      )..add(
          ConversationDetailRequested(
            loginAppUser: sender,
            receiver: receiver,
          ),
        ),
      child: ConversationView(
        loginAppUser: sender,
        receiver: receiver,
      ),
    );
  }
}
