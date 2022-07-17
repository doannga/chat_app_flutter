part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

//when AppUser presses the sign in or sign up button, the state is changed to loading first and then to authenticated.
class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

// When the AppUser is authenticated, the state is change to Authenticated
class Authenticated extends AuthState {
  @override
  List<Object> get props => [];
}

//init state of bloc. when the AppUser is not authenticated, the state is changed to authenticate
class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

//if having any error, state is changed to AuthError
class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}

class GetDetailRequestSuccess extends AuthState {
  final AppUser user;
  GetDetailRequestSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class GetDetailActionFailure extends AuthState {
  final String message;
  GetDetailActionFailure({required this.message});
  @override
  List<Object> get props => [message];
}
