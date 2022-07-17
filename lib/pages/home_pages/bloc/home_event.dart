part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeChatTapped extends HomeEvent {
  HomeChatTapped();
  @override
  List<Object> get props => [];
}

class HomePeopleTapped extends HomeEvent {
  HomePeopleTapped();
  @override
  List<Object> get props => [];
}
