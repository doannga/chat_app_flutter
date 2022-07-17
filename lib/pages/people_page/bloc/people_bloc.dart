import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_flutter/data/repositories/auth_repository.dart';

import '../../../models/user.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final AuthRepository peopleRepository;

  PeopleBloc(this.peopleRepository) : super(PeopleInitial()) {
    on<PeopleListRequested>((event, emit) async {
      try {
        final peopleList =
            await peopleRepository.getPeople(loginUID: event.loginUID);
        emit(PeopleLoadSuccess(peopleList: peopleList));
      } catch (e) {
        log('Issue while loading list people ${e.toString()}');
        emit(PeopleLoadFailure(message: 'Unable to load people list'));
      }
    });
  }
}
