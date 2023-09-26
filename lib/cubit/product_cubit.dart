import 'dart:async';
import 'dart:io';

import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState.initial());

  /// state of the product name enterered when uploading a product
  Future<void> productName({required String productName}) async {
    emit(
      state.copyWith(productName: productName),
    );
  }

  /// state of the product price enterered when uploading a product
  Future<void> productPrice({required String productPrice}) async {
    emit(
      state.copyWith(productPrice: productPrice),
    );
  }

  Future<void> productImageUrl({required String productImageUrl}) async {
    emit(
      state.copyWith(productImageUrl: productImageUrl),
    );
  }

  Future<void> isWantingImageFromUs(
      {required bool isWantingImageFromUs}) async {
    emit(
      state.copyWith(isWantingImageFromUs: isWantingImageFromUs),
    );
  }

  Future<void> additionalNotes({required String additionalNotes}) async {
    emit(
      state.copyWith(additionalNotes: additionalNotes),
    );
  }

  Future<void> minimumPrice({required String minimumPrice}) async {
    emit(
      state.copyWith(minimumPrice: minimumPrice),
    );
  }

  Future<void> maximumPrice({required String maximumPrice}) async {
    emit(
      state.copyWith(maximumPrice: maximumPrice),
    );
  }

  /// state of the brand model enterered when uploading a product
  Future<void> brandModel({required String brandModel}) async {
    emit(
      state.copyWith(brandModel: brandModel),
    );
  }

  /// state of the condition of the model when uploading a product
  Future<void> conditionOfItem({required String conditionOfItem}) async {
    emit(
      state.copyWith(conditionOfItem: conditionOfItem),
    );
  }

  Future<void> location({required String location}) async {
    emit(
      state.copyWith(location: location),
    );
  }

  Future<void> yearOfManufacture({required String yearOfManufacture}) async {
    emit(
      state.copyWith(yearOfManufacture: yearOfManufacture),
    );
  }

  ///This will capture the state of the backgrond photo based on the state of the
  ///category the user selects
  Future<void> mainScreenBackgroundPhoto(
      {required String mainScreenBackgroundPhoto}) async {
    emit(
      state.copyWith(
        mainScreenBackgroundPhoto: mainScreenBackgroundPhoto,
      ),
    );
  }

  void changeMainScreenBackgroundPhoto() async {
    if (state.selectedCategory == 'HEAVY EQUIPMENT') {
      state.mainScreenBackgroundPhoto ==
          '/Users/nickcamson/vildi1/lib/assets/sprayer.jpg';
    } else {
      state.mainScreenBackgroundPhoto ==
          '/Users/nickcamson/vildi1/lib/assets/barn.jpg';
    }
  }

  Future<void> sendSelectedItemTotextfield(
      {required String sendSelectedItemTotextfield}) async {
    emit(
      state.copyWith(sendSelectedItemTotextfield: sendSelectedItemTotextfield),
    );
  }

  /// store the category that the user selects from the dropdown menu on the main page.
  /// I should consider reverting this to a case switch
  Future<void> selectedCategory({required String selectedCategory}) async {
    String newBackgroundPhoto;

    switch (selectedCategory) {
      case 'HEAVY EQUIPMENT':
        newBackgroundPhoto = '/Users/nickcamson/vildi1/lib/assets/sprayer.jpg';
        break;
      case 'FARM & GARDEN':
        newBackgroundPhoto = '/Users/nickcamson/vildi1/lib/assets/farm.jpg';
        break;

      case 'JUMBLE BIN':
        newBackgroundPhoto = '/Users/nickcamson/vildi1/lib/assets/antiques.jpg';
        break;

      case 'REAL ESTATE':
        newBackgroundPhoto = '/Users/nickcamson/vildi1/lib/assets/cabin.jpg';
        break;

      case 'VEHICLES':
        newBackgroundPhoto = '/Users/nickcamson/vildi1/lib/assets/ford.jpg';
        break;

      case 'ATV/BOAT/CAMPING':
        newBackgroundPhoto = '/Users/nickcamson/vildi1/lib/assets/boat.jpg';
        break;

      default:
        newBackgroundPhoto = '/Users/nickcamson/vildi1/lib/assets/barn.jpg';
    }

    emit(
      state.copyWith(
        selectedCategory: selectedCategory,
        mainScreenBackgroundPhoto: newBackgroundPhoto,
      ),
    );
  }

  /// state of the product details enterered when uploading a product
  Future<void> productDetails({required String productDetails}) async {
    emit(
      state.copyWith(
        productDetails: productDetails,
      ),
    );
  }

  Future<void> productPhoto({required String productPhoto}) async {
    emit(
      state.copyWith(
        productPhoto: productPhoto,
      ),
    );
  }

  Future<void> randomProductStringState(
      {required String randomProductStringState}) async {
    emit(
      state.copyWith(
        randomProductStringState: randomProductStringState,
      ),
    );
  }

  /// this will be called in the alert dialog when the user submits a product
  void writeProductDetailsToProductsCollection() async {
    /// this probably should not be random
    /// it should most likely be state.user + (an identfiable element, say state.product name or state.dateuploded)
    /// these are suggestions, but i want you to think about it.
    /// Go over this with corbin
    //! After some thought, I'm of the mindset that this actually may be
    //! best if its a random string, so long as you can keep track of it.
    String getRandomString(int length) {
      const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
      Random rnd = Random();
      String result = '';
      for (var i = 0; i < length; i++) {
        result += chars[rnd.nextInt(chars.length)];
      }
      return result;
    }

    String randomDoc = getRandomString(20);
    randomProductStringState(randomProductStringState: randomDoc);

    try {
      final user = FirebaseAuth.instance.currentUser!.uid;
      final usersCollection = FirebaseFirestore.instance.collection('products');
      await usersCollection.doc(randomDoc).set({
        'productCategory': state.sendSelectedItemTotextfield,
        'productName': state.productName,
        'productModel': state.productDetails,
        'productCondition': state.conditionOfItem,
        'buyerLocation': state.location,
        'maximumPrice': state.maximumPrice,
        'additionalNotes': state.additionalNotes,
        'productImageUrl': state.productImageUrl,
        'posterId': user
      });
    } catch (e) {
      print('Error writing to Firestore: $e');
    }
  }

  void writePostDetailsToUsersCollection() async {
    String randomDoc = state.randomProductStringState;

    try {
      final user = FirebaseAuth.instance.currentUser!.uid;
      final usersCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .collection('myPosts');
      await usersCollection.doc(randomDoc).set({
        'productCategory': state.sendSelectedItemTotextfield,
        'productName': state.productName,
        'productModel': state.productDetails,
        'productCondition': state.conditionOfItem,
        'buyerLocation': state.location,
        'maximumPrice': state.maximumPrice,
        'additionalNotes': state.additionalNotes,
        'productImageUrl': state.productImageUrl,
        // 'posterId': user
      });
    } catch (e) {
      print('Error writing to Firestore: $e');
    }
  }
//! This was using dart.html which will destroy projects

  /// Alert dialog shown to user to ensure that
  /// correct info is being uploaded to database.
  /// A lot of this UI should not be stored in your cubit
  //! you should seriously consider using placing this
  //! in a seperate file.
  Future<void> productAlertDialogConfirm(BuildContext context) async {
    bool? isChecked = false;
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Review Post Details',
                      // 'Our team reviews posts before \n making them public to ensure \n they adhere to our company policy. \n Would you like to submit the below \n information to our team?',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                const Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(height: 20),
                const Text(
                  'Product Name',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.productName,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Product Category',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.sendSelectedItemTotextfield,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Product Brand',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.productDetails,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Year Manufactured',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.yearOfManufacture,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Product Condition',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.conditionOfItem,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'General Location',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.location,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Product Maximum Price',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.maximumPrice,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Additional Notes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.additionalNotes,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 52,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 50,
                    backgroundImage: NetworkImage(state.productImageUrl),
                  ),
                  // https://firebasestorage.googleapis.com/v0/b/vildi-2492e.appspot.com/o/images%2F0757d016a5c9fdb.jpeg?alt=media&token=0db2ed2b-e52e-4ce7-89ac-82ab164d9ff2
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Centers the buttons
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red, // foreground
                      ),
                      child: const Text(
                        'No',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        /// this will write the deatils to firebase, but does not post them.
                        /// It's a business decision to decide if these 'posts' should be reviewed
                        /// before posting
                        writeProductDetailsToProductsCollection();
                        writePostDetailsToUsersCollection();

                        Navigator.pop(context);
                        context.read<HomeNavCubit>().changeTab(tab: 2);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => const CongratsPage(),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // foreground
                      ),
                      child: const Text(
                        'Submit!',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  uploadProductImageToFirebase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'heic', 'webp']);

    if (result != null) {
      PlatformFile file = result.files.first;

      // For web
      if (kIsWeb) {
        try {
          final storageRef = FirebaseStorage.instance.ref();
          final fileRef = storageRef.child('images/${file.name}');
          final snapshot = await fileRef.putData(file.bytes!);
          final String downloadUrl = await snapshot.ref.getDownloadURL();
          print("Upload successful: $downloadUrl");
          productImageUrl(productImageUrl: downloadUrl);
        } catch (e) {
          print("Failed to upload file: $e");
        }
      }
      // For mobile
      else {
        File pickedFile = File(file.path!);

        try {
          final storageRef = FirebaseStorage.instance.ref();
          final fileRef = storageRef.child('images/${file.name}');
          final snapshot = await fileRef.putFile(pickedFile);
          final String downloadUrl = await snapshot.ref.getDownloadURL();

          /// You could potentially display the imaeg that a usder selected as well
          ///  You just need to use a network image and have the state be initialzied to a renderable image
          // ignore: use_build_context_synchronously
          print("Upload successful: $downloadUrl hiii");
          productImageUrl(productImageUrl: downloadUrl);
        } catch (e) {
          print("Failed to upload file: $e");
        }
      }
    } else {
      print("No file picked");
    }
  }
}
