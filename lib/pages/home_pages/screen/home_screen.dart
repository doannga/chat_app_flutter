import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/pages/home_pages/screen/component/bottom_bar.dart';
import 'package:message_app_flutter/pages/people_page/screen/people_screen.dart';

import '../../../models/user.dart';
import '../../chat_page/screen/chat_screen.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  final AppUser userlogin;

  const HomeScreen({Key? key, required this.userlogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomePeople) {
            print('thuynga.dt: Chuyen sang man hinh PeopleScreen');
            return PeopleScreen(loginUser: userlogin);
            // return PeopleScreen();
          } else {
            print('thuynga.dt: Chuyen sang man hinh Chat Screen');
            return ChatScreen(loginAppUser: userlogin);
          }
        },
      ),
      bottomNavigationBar: BottomBar(onNaviSelected: (index) {
        if (index == 0) {
          BlocProvider.of<HomeBloc>(context).add(HomeChatTapped());
        } else {
          BlocProvider.of<HomeBloc>(context).add(HomePeopleTapped());
        }
      }),
    );
  }
}
