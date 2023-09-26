import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/auth_cubit.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';

part 'bid_state.dart';

/// This cubit will preserve the states of the
/// information a seller/bider uplaods. This will be strcutured
/// in a very similar way to how the buyer posting the wanted ad
/// uploads data pertaining to that product. Below will presevre the
/// state of various elements associated with the bids.
class BidCubit extends Cubit<BidState> {
  BidCubit() : super(BidState.initial());

  /// state of the product name enterered when uploading a product
  Future<void> productName({required String productName}) async {
    emit(
      state.copyWith(productName: productName),
    );
  }

  Future<void> productPrice({required String productPrice}) async {
    emit(
      state.copyWith(productPrice: productPrice),
    );
  }

  Future<void> bidAmount({required num bidAmount}) async {
    emit(
      state.copyWith(bidAmount: bidAmount),
    );
  }

  Future<void> bidderId({required String bidderId}) async {
    emit(
      state.copyWith(bidderId: bidderId),
    );
  }

  Future<void> username({required String username}) async {
    emit(
      state.copyWith(username: username),
    );
  }

  Future<void> posterId({required String posterId}) async {
    emit(
      state.copyWith(posterId: posterId),
    );
  }

  Future<void> productImage({required String productImage}) async {
    emit(
      state.copyWith(productImage: productImage),
    );
  }

  Future<void> location({required String location}) async {
    emit(
      state.copyWith(location: location),
    );
  }

  /// The purpose of this fucntion is to write details pertaining to
  /// the details of a specific user bid.
  void writeProductDetailsToFirebase(BuildContext context) async {
    final currentUserPostProductState =
        context.read<CurrentUserPostCubit>().state.productId;
    try {
      final user = FirebaseAuth.instance.currentUser!.uid;
      final usersCollection = FirebaseFirestore.instance
          .collection('products')
          .doc(currentUserPostProductState)
          .collection('bids');

      /// This is acting as a model to some degree
      await usersCollection.doc(user).set({
        // use user here
        // 'bidAmount': state.bidAmount,
        'bidderId': user,
        'username': context.read<AuthCubit>().state.user.name,
        // 'productName': state.productName,
        // 'productImage': state.productImage,
        // 'posterId': state.posterId,
        //! This should be coming from the current users profile
        //! They should set
        // 'location': state.location,
        'bidPrice': state.bidPrice,
        'bidProductCondition': state.bidProductCondition,
        'bidImageUrl': state.bidImageUrl,
      });
    } catch (e) {
      print('Error writing to Firestore: $e');
    }
  }

  /// This fucntion is modeled similar to the one above, with the difference
  /// that
  void writeBidDetailsToFirebaseCurrentUsersCollection(
      BuildContext context) async {
    final currentUserPostProductState =
        context.read<CurrentUserPostCubit>().state.productId;
    try {
      final user = FirebaseAuth.instance.currentUser!.uid;
      final usersCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .collection('bidsPlaced');

      /// This is acting as a model to some degree
      await usersCollection.doc(currentUserPostProductState).set({
        // use user here
        // 'bidAmount': state.bidAmount,
        'bidderId': user,
        'username': context.read<AuthCubit>().state.user.name,
        // 'productName': state.productName,
        // 'productImage': state.productImage,
        // 'posterId': state.posterId,
        //! This should be coming from the current users profile
        //! They should set
        // 'location': state.location,
        'bidPrice': state.bidPrice,
        'productid': currentUserPostProductState,
        'bidProductCondition': state.bidProductCondition,
        'bidImageUrl': state.bidImageUrl,
        'productName': context.read<CurrentUserPostCubit>().state.productName,
        'posterId': context.read<CurrentUserPostCubit>().state.username,
      });
    } catch (e) {
      print('Error writing to Firestore: $e');
    }
  }

  /// This fucntion will act very similar to the one above as well.
  /// However, I need to have the person that posted the 'ad'
  /// have a section appear and notify them when someone
  /// places a bid on one of the products they've posted
  void writeBidDetailsToFirebasePostUsersCollection(
      BuildContext context) async {
    String postId = context.read<CurrentUserPostCubit>().state.username;
    final currentUserPostProductState =
        context.read<CurrentUserPostCubit>().state.productId;
    try {
      print(postId);
      final user = FirebaseAuth.instance.currentUser!.uid;
      final usersCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(context.read<CurrentUserPostCubit>().state.username)
          .collection('offers');

      /// This is acting as a model to some degree
      /// This should be the ID of the bidder here. This accomplishes
      /// multiple things. First, multiple offers can be placed ona  product
      /// but a person cannot place multiple bids on the same product
      /// need to add
      await usersCollection.doc(user + currentUserPostProductState).set({
        // use user here
        // 'bidAmount': state.bidAmount,
        'bidderId': user,
        'username': context.read<AuthCubit>().state.user.name,
        'bidPrice': state.bidPrice,
        'productid': currentUserPostProductState,
        'bidProductCondition': state.bidProductCondition,
        'bidImageUrl': state.bidImageUrl,
        'productName': context.read<CurrentUserPostCubit>().state.productName,

        /// posterId is coming back null for some reason ... i need
        /// to figure out why
        'posterId': postId,
        'isAccepted': false,
      });
    } catch (e) {
      print('Error writing to Firestore: $e');
    }
  }

/// The purpose of this fucntion is to delete the bid data from the current users profile 
/// Maybe there should be more of a process to ensure the user would actually like the document
/// deleted, but for nows purpose this will be sufficient
  void deleteBidDetailsFromFirebasePostUsersCollection(
      BuildContext context, String productId) async {
    String postId = context.read<CurrentUserPostCubit>().state.username;
    final currentUserPostProductState =
        context.read<CurrentUserPostCubit>().state.productId;

    try {
      print("Deleting bid for post ID: $postId");
      final user = FirebaseAuth.instance.currentUser!.uid;
      final usersCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .collection('offers');

      await usersCollection
      /// This is probably gonna have to be based on firebase data and query doc.id or something.
          .doc(productId)
          .delete()
          .then((_) => print("Successfully deleted bid document"))
          .catchError(
              (error) => print("Failed to delete bid document: $error"));
    } catch (e) {
      print('Error deleting from Firestore: $e');
    }
  }

  /// These are the three state that I will be storing when uploading information
  /// to the bid section. There will be other states that will need to be captured,
  /// but will have already been captured in state and will be sent to the
  /// bids subCollection of the database.
  Future<void> bidProductCondition(
      {required String bidProductCondition}) async {
    emit(
      state.copyWith(bidProductCondition: bidProductCondition),
    );
  }

  Future<void> bidImageUrl({required String bidImageUrl}) async {
    emit(
      state.copyWith(bidImageUrl: bidImageUrl),
    );
  }

  Future<void> bidPrice({required num bidPrice}) async {
    emit(
      state.copyWith(bidPrice: bidPrice),
    );
  }

  /// Im aware it's not best practice to copy and paste a nee
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
          bidImageUrl(bidImageUrl: downloadUrl);
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
          bidImageUrl(bidImageUrl: downloadUrl);
        } catch (e) {
          print("Failed to upload file: $e");
        }
      }
    } else {
      print("No file picked");
    }
  }
}
