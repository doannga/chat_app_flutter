part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// When the AppUser sign in with email and password, this event is called and AuthRepository is called to sign in AppUser.
class SignInRequest extends AuthEvent {
  final String email;
  final String password;

  SignInRequest(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String phoneNumber;
  final String name;
  SignUpRequested(this.email, this.password, this.phoneNumber, this.name);
}

class GoogleSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

class GetDetailRequested extends AuthEvent {
  GetDetailRequested({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];
  final String uid;
}
