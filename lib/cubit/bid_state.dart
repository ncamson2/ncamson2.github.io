part of 'bid_cubit.dart';

class BidState extends Equatable {
  final String productName;
  final String productPrice;
  final num bidAmount;
  final String bidderId;
  final String username;
  final String productImage;
  final String posterId;
  final String location;
  final num bidPrice;
  final String bidProductCondition;
  final String bidImageUrl;

  // put a bool here that you can carry through state ...

  const BidState({
    required this.productName,
    required this.productPrice,
    required this.bidAmount,
    required this.bidderId,
    required this.posterId,
    required this.username,
    required this.productImage,
    required this.location,
    required this.bidPrice,
    required this.bidProductCondition,
    required this.bidImageUrl,
  });

  factory BidState.initial() {
    return const BidState(
      productName: '',
      productPrice: '',
      productImage: '',
      bidAmount: 0,
      bidderId: '',
      posterId: '',
      username: '',
      location: '',
      bidPrice: 0,
      bidProductCondition: '',
      bidImageUrl: '',
    );
  }

  @override
  List<Object?> get props => [
        productName,
        productPrice,
        productImage,
        bidAmount,
        bidderId,
        posterId,
        username,
        location,
        bidPrice,
        bidProductCondition,
        bidImageUrl,
      ];

  BidState copyWith({
    String? productName,
    String? productPrice,
    String? productImage,
    num? bidAmount,
    String? bidderId,
    String? posterId,
    String? username,
    String? location,
    num? bidPrice,
    String? bidProductCondition,
    String? bidImageUrl,
  }) {
    return BidState(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      bidAmount: bidAmount ?? this.bidAmount,
      posterId: posterId ?? this.posterId,
      productImage: productImage ?? this.productImage,
      bidderId: bidderId ?? this.bidderId,
      username: username ?? this.username,
      location: location ?? this.location,
      bidPrice: bidPrice ?? this.bidPrice,
      bidProductCondition: bidProductCondition ?? this.bidProductCondition,
      bidImageUrl: bidImageUrl ?? this.bidImageUrl,
    );
  }
}
