import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

part 'current_user_post_state.dart';

class CurrentUserPostCubit extends Cubit<CurrentUserPostState> {
  CurrentUserPostCubit() : super(CurrentUserPostState.initial());

  /// state of the product name enterered when uploading a product
  Future<void> productName({required String productName}) async {
    emit(
      state.copyWith(productName: productName),
    );
  }

  Future<void> postLength({required num postLength}) async {
    emit(
      state.copyWith(postLength: postLength),
    );
  }

  Future<void> productId({required String productId}) async {
    emit(
      state.copyWith(productId: productId),
    );
  }

  Future<void> isNetworkImage({required bool isNetworkImage}) async {
    emit(
      state.copyWith(isNetworkImage: isNetworkImage),
    );
  }

  /// These three fucntions are deisgned to capture the state of basic information pertaining to the post that will
  /// be used when switching to tab 5 of the homenav index
  Future<void> productImageUrl({required String productImageUrl}) async {
    emit(
      state.copyWith(productImageUrl: productImageUrl),
    );
  }

  Future<void> username({required String username}) async {
    emit(
      state.copyWith(username: username),
    );
  }

  Future<void> productCategory({required String productCategory}) async {
    emit(
      state.copyWith(productCategory: productCategory),
    );
  }

  Future<void> posterId({required String posterId}) async {
    emit(
      state.copyWith(posterId: posterId),
    );
  }

  Future<void> productPrice({required String productPrice}) async {
    emit(
      state.copyWith(productPrice: productPrice),
    );
  }

  Future<void> documentIdExtraInfo(
      {required String documentIdExtraInfo}) async {
    emit(
      state.copyWith(documentIdExtraInfo: documentIdExtraInfo),
    );
  }

  /// I believe this give all the needed fields in the produtcs section ... 
  Future<List<Map<String, dynamic>>> fetchCurrentUserPostData() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    print(user);

    /// This will work, but you'll be querying to much unneeded info if you do not
    /// make the docIds of posts presentable
    final collectionRef = FirebaseFirestore.instance.collection('products');
    // .doc(user)
    // .collection('artistOffers');

    List<Map<String, dynamic>> currentUserPostList = [];

    try {
      final snapshot = await collectionRef.limit(50).get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          /// This needs to be checked ... I'm assuming this is wrong

          // Extracting the desired fields and adding to a map
          //! This needs to be a model
          //! You're legit making a model without a model.
          /// But, it works and works well.
          Map<String, dynamic> currentUserPostData = {
            'posterUsername': data['posterUsername'],
            'productImageUrl': data['productImageUrl'],
            'productName': data['productName'],
            'posterId': data['posterId'],
            'maximumPrice': data['maximumPrice'],
            'productCategory': data['productCategory'],
            'docId': doc.id,
            'hasBids': data['hasBids'],
            'productCondition': data['productCondition'],
            'productModel': data['productModel'],
            'buyerLocation' : data['buyerLocation'],
          };

          currentUserPostList.add(currentUserPostData);
        }
      }
    } catch (error) {
      print('Error: $error');
    }
    print("Current User Post List: $currentUserPostList");

    return currentUserPostList;
  }

  /// This will fetch the data in the 'bids' subCollection. This is
  /// not responsible for writing the data to the db. That will be handled
  /// in a seperate function
  //! I just updated this and its possible I'm querying this wrong
  //! Preety sure it's good tho ... will test tomorrow 9/6
  Future<List<Map<String, dynamic>>> fetchUserBidData() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    print(user);
    final collectionRef = FirebaseFirestore.instance
        .collection('products')
        .doc(state.productId)
        .collection('bids');

    List<Map<String, dynamic>> userBidDataList = [];

    try {
      final snapshot = await collectionRef.limit(50).get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          /// This needs to be checked ... I'm assuming this is wrong

          // Extracting the desired fields and adding to a map
          /// These have eveolved into my model. I dont know if this is
          /// the way it should be done but it works really well.
          Map<String, dynamic> userBidData = {
            'bidPrice': data['bidPrice'],
            'bidderId': data['bidderId'],
            'username': data['username'],
            'bidImageUrl': data['bidImageUrl'],
            'bidProductCondition': data['bidProductCondition'],
            'docId': doc.id,
          };

          userBidDataList.add(userBidData);
        }
      }
    } catch (error) {
      print('Error: $error');
    }
    print("Venue Offer Data List: $userBidDataList");

    return userBidDataList;
  }

  /// The purpose of this fucntion is to fetch the data that has been uploaded
  /// to the savedPosts collection of the current user
  Future<List<Map<String, dynamic>>> fetchCurrentUserSavedPostData() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    print(user);

    /// This will work, but you'll be querying to much unneeded info if you do not
    /// make the docIds of posts presentable
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('savedPosts');
    // .doc(user)
    // .collection('artistOffers');

    List<Map<String, dynamic>> currentUserSavedPostList = [];

    try {
      final snapshot = await collectionRef.limit(50).get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          /// This needs to be checked ... I'm assuming this is wrong

          // Extracting the desired fields and adding to a map
          //! This needs to be a model
          //! You're legit making a model without a model.
          /// But, it works and works well.
          Map<String, dynamic> currentUserSavedPostData = {
            'isSaved': data['isSaved'],
            'maximumPrice': data['maximumPrice'],
            'posterId': data['posterId'],
            'productId': doc.id,
            'productImageUrl': data['productImageUrl'],
            'productName': data['productName'],
          };

          currentUserSavedPostList.add(currentUserSavedPostData);
        }
      }
    } catch (error) {
      print('Error: $error');
    }
    print("Current User Post List: $currentUserSavedPostList");

    return currentUserSavedPostList;
  }

  Future<List<Map<String, dynamic>>> fetchCurrentUserBidData() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    print(user);

    /// This will work, but you'll be querying to much unneeded info if you do not
    /// make the docIds of posts presentable
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('bidsPlaced');
    // .doc(user)
    // .collection('artistOffers');

    List<Map<String, dynamic>> currentUserBidDataList = [];

    try {
      final snapshot = await collectionRef.limit(50).get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          /// This needs to be checked ... I'm assuming this is wrong

          // Extracting the desired fields and adding to a map
          //! This needs to be a model
          //! You're legit making a model without a model.
          /// But, it works and works well.
          Map<String, dynamic> currentUserBidData = {
            'bidImageUrl': data['bidImageUrl'],
            'bidPrice': data['bidPrice'],
            'posterId': data['posterId'],
            'productId': doc.id,
            'bidderId': data['bidderId'],
            'username': data['username'],
            'productName': data['productName'],
            'bidProductCondition': data['bidProductCondition']

            /// you should probabbly add the initial max price here as well ...
            ///
          };

          currentUserBidDataList.add(currentUserBidData);
        }
      }
    } catch (error) {
      print('Error: $error');
    }
    print("Current User Post List: $currentUserBidDataList");

    return currentUserBidDataList;
  }

  Future<List<Map<String, dynamic>>> fetchCurrentUserOfferData() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    print(user);

    /// This will work, but you'll be querying to much unneeded info if you do not
    /// make the docIds of posts presentable
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('offers');
    // .doc(user)
    // .collection('artistOffers');

    List<Map<String, dynamic>> currentUserOfferDataList = [];

    try {
      final snapshot = await collectionRef.limit(50).get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          /// This needs to be checked ... I'm assuming this is wrong

          // Extracting the desired fields and adding to a map
          //! This needs to be a model
          //! You're legit making a model without a model.
          /// But, it works and works well.
          Map<String, dynamic> currentUserOfferData = {
            'bidImageUrl': data['bidImageUrl'],
            'bidPrice': data['bidPrice'],
            'posterId': data['posterId'],
            'productId': doc.id,
            'bidderId': data['bidderId'],
            'username': data['username'],
            'productName': data['productName'],
            'bidProductCondition': data['bidProductCondition'],
            // There's gonna be a lot of thing that don't have this field
            // be weary of this and dont have a null error crash your program
            'isAccepted': data['isAccepted'],

            /// you should probabbly add the initial max price here as well ...
            ///
          };

          currentUserOfferDataList.add(currentUserOfferData);
        }
      }
    } catch (error) {
      print('Error: $error');
    }
    print("Current User Post List: $currentUserOfferDataList");

    return currentUserOfferDataList;
  }

  /// This is being modeled in a very similar way to how the 'offers'
  /// listview is organized. However, this will be queried when ... actuallly
  /// maybe when you hit accept you just add a bool lmao
  Future<List<Map<String, dynamic>>> fetchAcceptedOfferData() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    print(user);

    /// This will work, but you'll be querying to much unneeded info if you do not
    /// make the docIds of posts presentable
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('acceptedOffers');
    // .doc(user)
    // .collection('artistOffers');

    List<Map<String, dynamic>> currentUserOfferDataList = [];

    try {
      final snapshot = await collectionRef.limit(50).get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          /// This needs to be checked ... I'm assuming this is wrong

          // Extracting the desired fields and adding to a map
          //! This needs to be a model
          //! You're legit making a model without a model.
          /// But, it works and works well.
          Map<String, dynamic> currentUserOfferData = {
            'bidImageUrl': data['bidImageUrl'],
            'bidPrice': data['bidPrice'],
            'posterId': data['posterId'],
            'productId': doc.id,
            'bidderId': data['bidderId'],
            'username': data['username'],
            'productName': data['productName'],
            'bidProductCondition': data['bidProductCondition']

            /// you should probabbly add the initial max price here as well ...
            ///
          };

          currentUserOfferDataList.add(currentUserOfferData);
        }
      }
    } catch (error) {
      print('Error: $error');
    }
    print("Current User Post List: $currentUserOfferDataList");

    return currentUserOfferDataList;
  }

  Future<void> updateIsAccepted({required String productId}) async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final documentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('offers')
        .doc(productId);

    try {
      await documentRef.update({'isAccepted': true});
    } catch (error) {
      print("Error updating isAccepted: $error");
    }
  }

  Future<void> acceptedOfferLength({required num acceptedOfferLength}) async {
    emit(
      state.copyWith(acceptedOfferLength: acceptedOfferLength),
    );
  }

  Future<Map<String, dynamic>> fetchCurrentUserPostDoc(String productId) async {
    final documentRef =
        FirebaseFirestore.instance.collection('products').doc(productId);

    try {
      final docSnapshot = await documentRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return {
          'posterUsername': data['posterUsername'],
          'productImageUrl': data['productImageUrl'],
          'productName': data['productName'],
          'posterId': data['posterId'],
          'maximumPrice': data['maximumPrice'],
          'productCategory': data['productCategory'],
          'docId': docSnapshot.id,
          'hasBids': data['hasBids'],
        };
      } else {
        print("Document doesn't exist");
        return {};
      }
    } catch (error) {
      print('Error: $error');
      return {};
    }
  }
}

//!
