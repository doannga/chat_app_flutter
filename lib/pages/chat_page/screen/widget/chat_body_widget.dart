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
    return ListTile(
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(receiver.avatar),
      // ),
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
    );
  }
}
