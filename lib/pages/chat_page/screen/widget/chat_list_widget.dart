import 'package:flutter/material.dart';
import 'package:message_app_flutter/pages/chat_page/screen/widget/chat_body_widget.dart';

import '../../../../models/conversation.dart';
import '../../../../models/user.dart';

class ChatList extends StatelessWidget {
  final List<Conversation> chats;
  final AppUser loginAppUser;
  const ChatList({Key? key, required this.chats, required this.loginAppUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chats.isEmpty
        ? const Text('There is no conversation')
        : ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final receiver = chat.creator.uid != loginAppUser.uid
                  ? chat.creator
                  : chat.receiver;
              return ChatBody(receiver: receiver, sender: loginAppUser);
            });
  }
}
