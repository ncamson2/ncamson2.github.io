part of 'pricetoggle_cubit.dart';


enum AnalyticsStatus { initial, loading, loaded, success, reset, error }

class PricetoggleState extends Equatable {
  final int index;

  const PricetoggleState({required this.index});

  factory PricetoggleState.initial() {
    return const PricetoggleState(
      index: 0,
    );
  }

  @override
  List<Object?> get props => [index];

  PricetoggleState copyWith({int? index}) {
    return PricetoggleState(index: index ?? this.index);
  }
}