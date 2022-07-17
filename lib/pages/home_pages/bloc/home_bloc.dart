import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeChat()) {
    on<HomeChatTapped>((event, emit) {
      print('thuynga.dt: HomeCHatTapped');
      emit(HomeChat());
    });

    on<HomePeopleTapped>((event, emit) {
      print('thuynga.dt: HomePeopleTapped');
      emit(HomePeople());
    });
  }
}
