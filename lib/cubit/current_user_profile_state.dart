part of 'current_user_profile_cubit.dart';

class CurrentUserProfileState extends Equatable {
  final String userLocation;
  final String productPrice;

  // put a bool here that you can carry through state ...

  const CurrentUserProfileState({
    required this.userLocation,
    required this.productPrice,
  });

  factory CurrentUserProfileState.initial() {
    return const CurrentUserProfileState(
      userLocation: '',
      productPrice: '',
    );
  }

  @override
  List<Object?> get props => [
        userLocation,
        productPrice,
      ];

  CurrentUserProfileState copyWith({
    String? userLocation,
    String? productPrice,
  }) {
    return CurrentUserProfileState(
      userLocation: userLocation ?? this.userLocation,
      productPrice: productPrice ?? this.productPrice,
    );
  }
}
