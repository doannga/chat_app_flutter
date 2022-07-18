import 'package:flutter/material.dart';

import '../../../../models/message.dart';
import 'message_body_widget.dart';

class MessageListView extends StatelessWidget {
  final String loginUID;
  final List<Message?> messages;
  const MessageListView({
    Key? key,
    required this.loginUID,
    required this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? const Text('Say Hi! No messages yet.')
        : ListView.builder(
            itemCount: messages.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              final message = messages[index];
              return MessageBody(
                isMe: message?.senderUID == loginUID,
                message: message,
              );
            },
          );
  }
}
