import 'package:equatable/equatable.dart';

class Product extends Equatable {
  // consider making this a document refernce
  final String productId;
  final String productName;

  /// This will be set to null until I introduce buyers/sellers
  final String posterId;
  final String productPhoto;
  final String productPrice;

//! you need a ton more here ...

  const Product({
    required this.productId,
    required this.productName,
    required this.posterId,
    required this.productPhoto,
    required this.productPrice,

    // required this.artistOrVenue,
  });

  static const empty = Product(
    productId: '',
    productName: '',
    posterId: '',
    productPhoto: '',
    productPrice: '',

    // artistOrVenue: '',
  );

  @override
  List<Object?> get props => [
        productId,
        productName,
        posterId,
        productPhoto,
        productPrice,
      ];

  Product copyWith({
    String? productId,
    String? productName,
    String? posterId,
    String? productPhoto,
    String? productPrice,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      posterId: posterId ?? this.posterId,
      productPhoto: productPhoto ?? this.productPhoto,
      productPrice: productPrice ?? this.productPrice,

      // artistOrVenue: artistOrVenue ?? this.artistOrVenue,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      /// same check here as the factory. 
      'productId': productId,
      'productName': productName,
      'posterId': posterId,
      'productPhoto': productPhoto,
      'productPrice': productPrice,
    };
  }

  factory Product.fromDocument(final doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return Product(
      /// make sure doc.id is correct and look how it's
      /// being called else where.
      productId: doc.id,
      productName: data?['productName'] ?? '',
      posterId: data?['posterId'] ?? '',
      productPhoto: data?['productPhoto'] ?? '',
      productPrice: data?['bio_info'] ?? '',
    );
  }
}
//KEVIN HERE
