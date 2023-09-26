import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';

/// this fucntions correctly. Now, let's seperate the business logic from the design
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';

class SavePostButton extends StatefulWidget {
  final double height;
  final double width;

  const SavePostButton({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  _SavePostButtonState createState() => _SavePostButtonState();
}

class _SavePostButtonState extends State<SavePostButton> {
  bool isPressed = false;
  final SavePostLogic logic = SavePostLogic();

  @override
  void initState() {
    super.initState();
    initSavedState();
  }

  Future<void> initSavedState() async {
    bool saved = await logic
        .checkIfSaved(context.read<CurrentUserPostCubit>().state.productId);
    setState(() {
      isPressed = saved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserPostCubit, CurrentUserPostState>(
      builder: (context, state) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isPressed = !isPressed;
                });
                if (isPressed) {
                  await logic.saveProduct(
                      productId: state.productId,
                      productName: state.productName,
                      productImageUrl: state.productImageUrl,
                      productPrice: state.productPrice,
                      posterId: state.posterId);
                } else {
                  await logic.unsaveProduct(state.productId);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                // this should really be if the documentId of the currently signed in user
                // is placed in a the subCollection 'saves'
                backgroundColor: isPressed ? Colors.red : Colors.transparent,
                shadowColor: Colors.transparent, // Remove elevation shadow
                elevation: 0, // Remove elevation
                side: BorderSide(color: Colors.white, width: 2), // White border
              ),
              child: Text(
               isPressed  ? 'Tap To Unsave this Product!' : 'Tap To Save This Product!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// This should probabluy be transported to a cubit ...
/// 'SavePostCubit or something...
class SavePostLogic {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> saveProduct({
    required String productId,
    required String productName,
    required String productImageUrl,
    required String productPrice,
    required String posterId,
  }) async {
    final user = auth.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(user)
        .collection('savedPosts')
        .doc(productId)
        .set({
      'isSaved': true,
      'productId': productId,
      'productName': productName,
      'productImageUrl': productImageUrl,
      'maximumPrice': productPrice,
      'posterId': posterId,
    }, SetOptions(merge: true));
    firestore
        .collection('products')
        .doc(productId)
        .collection('saves')
        .doc(user)
        .set({
      'isSaved': true,
      'saver': user,
    }, SetOptions(merge: true));
  }

  Future<void> unsaveProduct(String productId) async {
    final user = auth.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(user)
        .collection('savedPosts')
        .doc(productId)
        .delete();
    firestore
        .collection('products')
        .doc(productId)
        .collection('saves')
        .doc(user)
        .delete();
  }

  Future<bool> checkIfSaved(String productId) async {
    final user = auth.currentUser!.uid;
    DocumentSnapshot documentSnapshot = await firestore
        .collection('products')
        .doc(productId)
        .collection('saves')
        .doc(user)
        .get();
    return documentSnapshot.exists;
  }
}

///
///This is my previous is saved button fucntion that works and uses a boolean

// Future<void> checkIfSaved() async {
//     String productId = context.read<CurrentUserPostCubit>().state.productId;
//     final user = FirebaseAuth.instance.currentUser!.uid;

//     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
//         .collection('products')
//         .doc(productId)
//         .collection('saves')
//         .doc(user)
//         .get();

//     if (documentSnapshot.exists) {
//       Map<String, dynamic>? data =
//           documentSnapshot.data() as Map<String, dynamic>?;
//       if (data != null && data.containsKey('isSaved')) {
//         bool isSaved = data['isSaved'];
//         setState(() {
//           isPressed = isSaved; // Set isPressed to whatever isSaved is.
//         });
//       }
//     } else {
//       setState(() {
//         isPressed = false;
//       });
//     }
//   }
