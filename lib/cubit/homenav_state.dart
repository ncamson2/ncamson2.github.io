part of 'homenav_cubit.dart';

enum AnalyticsStatus { initial, loading, loaded, success, reset, error }

class HomeNavState extends Equatable {
  final int index;

  const HomeNavState({required this.index});

  factory HomeNavState.initial() {
    return const HomeNavState(
      index: 0,
    );
  }

  @override
  List<Object?> get props => [index];

  HomeNavState copyWith({int? index}) {
    return HomeNavState(index: index ?? this.index);
  }
}