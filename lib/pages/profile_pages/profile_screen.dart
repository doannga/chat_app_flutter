import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/pages/landing_screen_pages/landing_screen.dart';
import 'package:message_app_flutter/pages/login_pages/auth_bloc/auth_bloc.dart';

import '../../models/user.dart';

class ProfileScreen extends StatelessWidget {
  final AppUser userLogin;
  const ProfileScreen({Key? key, required this.userLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
              context.read<AuthBloc>().add(SignOutRequested());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LandingScreen()));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: TextButton(
                onPressed: () {},
                child: userLogin.avatar == ''
                    ? FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.all(50),
                          child: Text(
                            userLogin.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 80),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(userLogin.avatar),
                      ),
              ),
            ),
            Text(
              userLogin.name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              userLogin.email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              userLogin.phoneNumber,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                onPrimary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Me:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'The “about us” page is a must-have page (this can be a page on your website, separate landing page or even “about me” website as a type of portfolio) used by all types of businesses to give customers more insight into who is involved with a given business and exactly what it does.',
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
