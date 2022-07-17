import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/data/provider/chat_firebase_provider.dart';
import 'package:message_app_flutter/data/repositories/chat_repository.dart';
import 'package:message_app_flutter/pages/chat_page/bloc/chat_bloc.dart';
import 'package:message_app_flutter/pages/chat_page/screen/widget/chat_view_widget.dart';

import '../../../models/user.dart';

class ChatScreen extends StatelessWidget {
  static const String id = 'chat_screen';
  final AppUser loginAppUser;
  const ChatScreen({Key? key, required this.loginAppUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        chatRepository: ChatRepository(
          chatFirebaseProvider:
              ChatFirebaseProvider(firestore: FirebaseFirestore.instance),
        ),
      )..add(ChatRequested(currentUid: loginAppUser.uid)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          centerTitle: true,
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(''),
          // ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.post_add)),
          ],
        ),
        body: ChatView(
          loginAppUser: loginAppUser,
        ),
      ),
    );
  }
}
