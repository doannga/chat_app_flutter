import 'package:flutter/material.dart';

import '../../../../models/user.dart';
import '../../../conversation_page/screen/conversation_screen.dart';

class ChatBody extends StatelessWidget {
  final AppUser receiver;
  final AppUser sender;
  const ChatBody({Key? key, required this.receiver, required this.sender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push<MaterialPageRoute>(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(
              receiver: receiver,
              sender: sender,
            ),
          ),
        );
      },
      child: ListTile(
        leading: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            padding: const EdgeInsets.all(8),
            child: Text(receiver.name.substring(0, 1).toUpperCase()),
          ),
        ),
        title: Text(receiver.name),
        subtitle: Text(receiver.email),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () {
            Navigator.push<MaterialPageRoute>(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationScreen(
                  receiver: receiver,
                  sender: sender,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
