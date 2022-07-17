import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/pages/chat_page/screen/widget/chat_list_widget.dart';

import '../../../../models/user.dart';
import '../../bloc/chat_bloc.dart';

class ChatView extends StatelessWidget {
  final AppUser loginAppUser;
  const ChatView({Key? key, required this.loginAppUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoadInprogress) {
            return const CircularProgressIndicator();
          } else if (state is ChatLoadFailure) {
            return const Text('Unable to load chats');
          } else if (state is ChatLoadSuccess) {
            return ChatList(chats: state.chats, loginAppUser: loginAppUser);
          }
          return Text(
            'Not found state ${state.runtimeType.toString()}',
          );
        },
      ),
    );
  }
}
