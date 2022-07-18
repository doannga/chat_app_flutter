import 'package:flutter/material.dart';

import '../../../../models/message.dart';

class MessageBody extends StatelessWidget {
  final bool isMe;
  final Message? message;

  const MessageBody({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueGrey : Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Text(
          message?.content ?? '',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
