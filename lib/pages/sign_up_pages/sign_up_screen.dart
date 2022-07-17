import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/pages/home_pages/screen/home_screen.dart';

import '../../data/repositories/auth_repository.dart';
import '../../models/user.dart';
import '../home_pages/bloc/home_bloc.dart';
import '../login_pages/auth_bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const String id = 'sign_up_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  void _createAccountWithEmailAndPassword(BuildContext context) {
    // check validate email and password
    BlocProvider.of<AuthBloc>(context).add(SignUpRequested(emailController.text,
        passwordController.text, phoneController.text, nameController.text));
  }

  void _getUserLogin(BuildContext context) {}

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(GoogleSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
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
            // display error if AppUser is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              //show loading
              child: CircularProgressIndicator(),
            );
          }
          if (state is UnAuthenticated) {
            return Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 200,
                    width: 200,
                    child: Icon(Icons.message),
                  ),
                  const Spacer(),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
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
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
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
                      color: Colors.blueAccent,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      elevation: 5,
                      child: MaterialButton(
                        onPressed: () {
                          //Implement sign up functionality.
                          print(nameController.text);
                          print(phoneController.text);
                          print(emailController.text);
                          print(passwordController.text);
                          _createAccountWithEmailAndPassword(context);
                        },
                        minWidth: 200,
                        height: 42,
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
