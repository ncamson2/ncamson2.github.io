part of 'current_user_post_cubit.dart';

/// The idea behind this is to capture the state of various elements of posts
/// that the signed in user uploaded.
class CurrentUserPostState extends Equatable {
  final String productName;
  final String productPrice;
  final bool isNetworkImage;
  final String productId;
  final String productImageUrl;
  final String productCategory;
  final String posterId;
  final num bidPrice;
  final String bidProductCondition;
  final String bidImageUrl;
  final num postLength;
  final String username;
  final num acceptedOfferLength;
  final String documentIdExtraInfo;

  // put a bool here that you can carry through state ...

  const CurrentUserPostState({
    required this.productName,
    required this.productPrice,
    required this.isNetworkImage,
    required this.productId,
    required this.productImageUrl,
    required this.productCategory,
    required this.posterId,
    required this.bidPrice,
    required this.bidProductCondition,
    required this.bidImageUrl,
    required this.postLength,
    required this.username,
    required this.acceptedOfferLength,
    required this.documentIdExtraInfo,
  });

  factory CurrentUserPostState.initial() {
    return const CurrentUserPostState(
      productName: '',
      productPrice: '',
      isNetworkImage: true,
      productId: '',
      productImageUrl: '',
      productCategory: '',
      posterId: '',
      bidPrice: 0,
      bidProductCondition: '',
      bidImageUrl: '',
      postLength: 0,
      username: '',
      acceptedOfferLength: 0,
      documentIdExtraInfo: '',
    );
  }

  @override
  List<Object?> get props => [
        productName,
        productPrice,
        isNetworkImage,
        productId,
        productImageUrl,
        bidPrice,
        bidProductCondition,
        bidImageUrl,
        postLength,
        username,
        acceptedOfferLength,
        documentIdExtraInfo,
      ];

  CurrentUserPostState copyWith({
    String? productName,
    String? productPrice,
    bool? isNetworkImage,
    String? productId,
    String? productImageUrl,
    String? productCategory,
    String? posterId,
    num? bidPrice,
    String? bidProductCondition,
    String? bidImageUrl,
    num? postLength,
    String? username,
    num? acceptedOfferLength,
    String? documentIdExtraInfo,
  }) {
    return CurrentUserPostState(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      isNetworkImage: isNetworkImage ?? this.isNetworkImage,
      productId: productId ?? this.productId,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      productCategory: productCategory ?? this.productCategory,
      posterId: posterId ?? this.posterId,
      bidPrice: bidPrice ?? this.bidPrice,
      bidProductCondition: bidProductCondition ?? this.bidProductCondition,
      bidImageUrl: bidImageUrl ?? this.bidImageUrl,
      postLength: postLength ?? this.postLength,
      username: username ?? this.username,
      acceptedOfferLength: acceptedOfferLength ?? this.acceptedOfferLength,
      documentIdExtraInfo: documentIdExtraInfo ?? this.documentIdExtraInfo,
    );
  }
}
/// These statement sshould be stored in state
// 'posterUsername': data['posterUsername'],
//             'productImageUrl': data['productImageUrl'],
//             'productName': data['productName'],
//             'posterId': data['posterId'],
//             'maximumPrice': data['maximumPrice'],
//             'productCategory': data['productCategory'],
//             'docId': doc.id,
//! What if i could make a program that would remove a lot of this boiler plate
//! code ... like legit the only purpose of these files is to store the state 
//! of a variable.
//! I always feel like i could write this in flutter and contribute it to the 
//! community ... that'd be such a fun projecr