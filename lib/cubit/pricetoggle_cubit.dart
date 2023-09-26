import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pricetoggle_state.dart';

class PricetoggleCubit extends Cubit<PricetoggleState> {
  PricetoggleCubit() : super(PricetoggleState.initial());

  /// state of the product name enterered when uploading a product

  Future<void> changeTab({required int tab}) async {
    emit(state.copyWith(index: tab));
  }
}
