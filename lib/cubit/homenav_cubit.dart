import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homenav_state.dart';

class HomeNavCubit extends Cubit<HomeNavState> {
  HomeNavCubit() : super(HomeNavState.initial());

  Future<void> changeTab({required int tab}) async {
    emit(state.copyWith(index: tab));
  }
}
