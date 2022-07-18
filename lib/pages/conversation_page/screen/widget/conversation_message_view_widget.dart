import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/pages/conversation_page/screen/widget/message_list_view_widget.dart';

import '../../../../models/user.dart';
import '../../bloc/message_receiver_bloc.dart';

class ConversationMessageView extends StatelessWidget {
  final AppUser loginAppUser;
  final AppUser receiver;

  const ConversationMessageView({
    Key? key,
    required this.loginAppUser,
    required this.receiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<MessageReceiverBloc, MessageReceiverState>(
        builder: (context, state) {
          // if (state is MessageLoadInprogress) {
          //   return const CircularProgressIndicator();
          // } else
          if (state is MessageLoadFailure) {
            return Text('Unable to fetch Message ${state.message}');
          } else if (state is MessageLoadSuccess) {
            if (state.messages != null) {
              return MessageListView(
                messages: state.messages,
                loginUID: loginAppUser.uid,
              );
            }
          }
          return const Text(
            'Say Hi! No messages yet.',
          );
        },
      ),
    );
  }
}
