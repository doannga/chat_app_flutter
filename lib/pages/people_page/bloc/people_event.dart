// Defined events
part of 'people_bloc.dart';

abstract class PeopleEvent extends Equatable {}

class PeopleListRequested extends PeopleEvent {
  final String loginUID;
  PeopleListRequested({required this.loginUID});
  @override
  List<Object> get props => [];
}
