import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/data/repositories/auth_repository.dart';
import 'package:message_app_flutter/pages/landing_screen_pages/landing_screen.dart';
import 'package:message_app_flutter/pages/login_pages/auth_bloc/auth_bloc.dart';
import 'package:message_app_flutter/pages/login_pages/screen/login_screen.dart';
import 'package:message_app_flutter/pages/sign_up_pages/sign_up_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    //   MultiBlocProvider(
    // providers: [
    //   // BlocProvider<HomeBloc>(
    //   //   create: (context) => HomeBloc(), //?
    //   // ), // Vì HomeBloc cần tham số là user để khởi tạo, nên mình sẽ ko khởi tạo ở main
    //   BlocProvider<PeopleBloc>(
    //     create: (context) => PeopleBloc(
    //       AuthRepository(),
    //     ),
    //   ),
    //   BlocProvider<ConversationBloc>(
    //     create: (context) => ConversationBloc(
    //       conversationRepository: ConversationRepository(
    //         conversationFirebaseProvider: ConversationFirebaseProvider(
    //           firestore: FirebaseFirestore.instance,
    //         ),
    //       ),
    //     ),
    //   ),
    // ],
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data;
                print(user?.uid);

                //return const ChatScreen(loginAppUser: user.uid);
              }
              return const LandingScreen();
            },
          ),
          //routes
          initialRoute: LandingScreen.id,
          routes: {
            LandingScreen.id: (context) => const LandingScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            SignUpScreen.id: (context) => const SignUpScreen(),
          },
        ),
      ),
    );
  }
}
