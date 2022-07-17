import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/data/repositories/auth_repository.dart';
import 'package:message_app_flutter/pages/home_pages/screen/home_screen.dart';

import '../../../models/user.dart';
import '../../home_pages/bloc/home_bloc.dart';
import '../auth_bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _authenticateWithEmailAndPassword(context) {
    BlocProvider.of<AuthBloc>(context)
        .add(SignInRequest(emailController.text, passwordController.text));
  }

  // void _authenticateWithGoogle(context) {
  //   BlocProvider.of<AuthBloc>(context).add(GoogleSignInRequested());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the AppUser is authenticated
            print('thuynga.dt: Login successfully  ');

            User? userAuth = FirebaseAuth.instance.currentUser;
            try {
              AppUser? user =
                  await AuthRepository().getUserDetail(uid: userAuth?.uid);
              if (user != null) {
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<HomeBloc>(
                      create: (_) => HomeBloc(),
                      child: HomeScreen(userlogin: user),
                    ),
                  ),
                  (route) => false,
                );
              } else {
                throw Exception('can not get user');
              }
            } catch (e) {
              throw Exception('can not get user');
            }
          }
          if (state is AuthError) {
            print('thuynga.dt: Error');
            // Showing the error message if the AppUser has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SizedBox(
                    //   height: 200,
                    //   child: Image.asset(''),
                    // ),
                    const SizedBox(height: 48),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password.',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Material(
                        color: Colors.lightBlueAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        elevation: 5,
                        child: MaterialButton(
                          onPressed: () {
                            //Implement login function
                            _authenticateWithEmailAndPassword(context);
                          },
                          minWidth: 200,
                          height: 42,
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Undefined state');
            }
          },
        ),
      ),
    );
  }
}
