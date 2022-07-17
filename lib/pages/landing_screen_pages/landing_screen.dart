import 'package:flutter/material.dart';
import 'package:message_app_flutter/pages/sign_up_pages/sign_up_screen.dart';

import '../login_pages/screen/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  static const String id = 'landing_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 200, 24, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   height: 60,
            //   child: Image.asset(''),
            // ),
            const Text(
              'Message App',
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    Navigator.pushNamed(context, SignUpScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Sign up',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
