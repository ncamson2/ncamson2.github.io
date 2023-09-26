part of 'product_cubit.dart';

enum AnalyticsStatus { initial, loading, loaded, success, reset, error }

class ProductState extends Equatable {
  final String productName;
  final String productPrice;
  final String productDetails;
  final String productPhoto;
  final String mainScreenBackgroundPhoto;
  final String selectedCategory;
  final String brandModel;
  final String conditionOfItem;
  final String location;
  final String yearOfManufacture;
  final String minimumPrice;
  final String maximumPrice;
  final String additionalNotes;
  final String productImageUrl;
  final bool isWantingImageFromUs;
  final String sendSelectedItemTotextfield;
  final String randomProductStringState;

  // put a bool here that you can carry through state ...

  const ProductState(
      {required this.productName,
      required this.productPrice,
      required this.productDetails,
      required this.productPhoto,
      required this.mainScreenBackgroundPhoto,
      required this.selectedCategory,
      required this.brandModel,
      required this.conditionOfItem,
      required this.location,
      required this.yearOfManufacture,
      required this.minimumPrice,
      required this.maximumPrice,
      required this.additionalNotes,
      required this.productImageUrl,
      required this.isWantingImageFromUs,
      required this.sendSelectedItemTotextfield,
      required this.randomProductStringState});

  factory ProductState.initial() {
    return const ProductState(
      productName: '',
      productPrice: '',
      productDetails: '',
      productPhoto: '',
      // You want this to be the initial barn photo probably ...
      // make sure this is not null.
      mainScreenBackgroundPhoto: '/Users/nickcamson/vildi1/lib/assets/barn.jpg',
      selectedCategory: 'Farm and Garden',
      location: '',
      conditionOfItem: 'No condition specified',
      brandModel: '',
      yearOfManufacture: '',
      maximumPrice: '',
      minimumPrice: '',
      additionalNotes: 'No Additional Notes',
      productImageUrl:
          'https://firebasestorage.googleapis.com/v0/b/vildi-2492e.appspot.com/o/images%2FIMG_2586-modified-removebg-preview.png?alt=media&token=91388e57-7949-43eb-bc99-59fa6f43d690',
      // This should be initizaled to reflect how we want to go about this process
      isWantingImageFromUs: true,
      sendSelectedItemTotextfield: 'Select a Category!!!',
      randomProductStringState: '',
    );
  }

  @override
  List<Object?> get props => [
        productName,
        productPrice,
        productDetails,
        productPhoto,
        mainScreenBackgroundPhoto,
        selectedCategory,
        location,
        brandModel,
        conditionOfItem,
        yearOfManufacture,
        maximumPrice,
        minimumPrice,
        additionalNotes,
        productImageUrl,
        isWantingImageFromUs,
        sendSelectedItemTotextfield,
        randomProductStringState
      ];

  ProductState copyWith({
    String? productName,
    String? productPrice,
    String? productDetails,
    String? productPhoto,
    String? mainScreenBackgroundPhoto,
    String? selectedCategory,
    String? location,
    String? brandModel,
    String? conditionOfItem,
    String? yearOfManufacture,
    String? maximumPrice,
    String? minimumPrice,
    String? additionalNotes,
    String? productImageUrl,
    bool? isWantingImageFromUs,
    String? sendSelectedItemTotextfield,
    String? randomProductStringState,
  }) {
    return ProductState(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productDetails: productDetails ?? this.productDetails,
      productPhoto: productPhoto ?? this.productPhoto,
      mainScreenBackgroundPhoto:
          mainScreenBackgroundPhoto ?? this.mainScreenBackgroundPhoto,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      brandModel: brandModel ?? this.brandModel,
      location: location ?? this.location,
      conditionOfItem: conditionOfItem ?? this.conditionOfItem,
      yearOfManufacture: yearOfManufacture ?? this.yearOfManufacture,
      minimumPrice: minimumPrice ?? this.minimumPrice,
      maximumPrice: maximumPrice ?? this.maximumPrice,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      isWantingImageFromUs: isWantingImageFromUs ?? this.isWantingImageFromUs,
      sendSelectedItemTotextfield:
          sendSelectedItemTotextfield ?? this.sendSelectedItemTotextfield,
      randomProductStringState:
          randomProductStringState ?? this.randomProductStringState,
    );
  }
}
