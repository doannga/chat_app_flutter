import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/data/repositories/auth_repository.dart';

import '../../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    //AppUser presses Signin Button, we send SignInRequested to AuthBloc to handle it and emit Auth state if AppUser is authenticated
    on<SignInRequest>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);

        emit(Authenticated());
        //emit(Authenticated(user: user));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        User? userAuth = await authRepository.signUp(
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber,
            name: event.name);

        final user = await authRepository.getUserDetail(uid: userAuth?.uid);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    // on<GoogleSignInRequested>((event, emit) async {
    //   emit(Loading());
    //   try {
    //     await authRepository.signInWithGoogle();
    //     emit(Authenticated(user: null));
    //   } catch (e) {
    //     emit(AuthError(e.toString()));
    //     emit(UnAuthenticated());
    //   }
    // });
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
    on<GetDetailRequested>((event, emit) async {
      try {
        emit(Loading());
        final user = await authRepository.getUserDetail(uid: event.uid);
        emit(
          user == null
              ? GetDetailActionFailure(message: 'User is not found')
              : GetDetailRequestSuccess(user: user),
        );
      } catch (e) {
        log('Unexpected error occured ${e.toString()}');
      }
    });
  }
}
