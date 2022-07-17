import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/data/repositories/auth_repository.dart';
import 'package:message_app_flutter/models/user.dart';
import 'package:message_app_flutter/pages/conversation_page/conversation.dart';
import 'package:message_app_flutter/pages/people_page/bloc/people_bloc.dart';

class PeopleScreen extends StatefulWidget {
  final AppUser loginUser;
  const PeopleScreen({Key? key, required this.loginUser}) : super(key: key);

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PeopleBloc(AuthRepository())
        ..add(PeopleListRequested(loginUID: widget.loginUser.uid)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('People'),
          centerTitle: true,
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(''),
          // ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.post_add)),
          ],
        ),
        body: Center(
          child: BlocBuilder<PeopleBloc, PeopleState>(
            builder: (context, state) {
              if (state is PeopleLoadInprogress) {
                return const CircularProgressIndicator();
              } else if (state is PeopleLoadFailure) {
                return const Text('Unable to load people');
              } else if (state is PeopleLoadSuccess) {
                final peopleList = state.peopleList;
                if (peopleList.isNotEmpty) {
                  return ListView.builder(
                      itemCount: peopleList.length,
                      itemBuilder: (context, index) {
                        final people = peopleList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConversationScreen(
                                        sender: widget.loginUser,
                                        receiver: people)));
                          },
                          child: ListTile(
                            leading: people.avatar == ''
                                ? FittedBox(
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Text(people.name
                                          .substring(0, 1)
                                          .toUpperCase()),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(people.avatar),
                                  ),
                            title: Text(people.name),
                            subtitle: Text(people.email),
                          ),
                        );
                      });
                } else {
                  return const Center(child: Text('There is no one.'));
                }
              } else {
                // trang thai PeopleInitial
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
