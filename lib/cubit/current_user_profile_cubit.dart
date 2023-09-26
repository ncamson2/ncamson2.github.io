import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'current_user_profile_state.dart';

/// This cubit is going to store information that will be stored for the
/// purpose of being tied to the current user. Right now the only
/// line of code that resemebles something close to this functionality is
/// the auth cubit. However, you need to account for silent login.
class CurrentUserProfileCubit extends Cubit<CurrentUserProfileState> {
  CurrentUserProfileCubit() : super(CurrentUserProfileState.initial());

  /// state of the product name enterered when uploading a product
  Future<void> userLocation({required String userLocation}) async {
    emit(
      state.copyWith(userLocation: userLocation),
    );
  }

  Future<void> productPrice({required String productPrice}) async {
    emit(
      state.copyWith(productPrice: productPrice),
    );
  }
}
