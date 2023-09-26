// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:vildi1/farm_card/current_user_post_card.dart';

// // Begin custom widget code
// // DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import 'package:firebase_auth/firebase_auth.dart';

// // Set your widget name, define your parameter, and then add the
// // boilerplate code using the button on the right!
// Future<List<Map<String, dynamic>>> fetchCurrentUserPostData() async {
//   final collectionRef = FirebaseFirestore.instance.collection('proposals');
//   List<Map<String, dynamic>> currentUserPostList = [];
//   try {
//     final snapshot = await collectionRef.limit(50).get();
//     if (snapshot.docs.isNotEmpty) {
//       for (var doc in snapshot.docs) {
//         final data = doc.data() as Map<String, dynamic>;
//         Map<String, dynamic> currentUserPostData = {
//           'elevatorPitch': data['elevatorPitch'],
//           'contact': data['contact'],
//           'budget': data['budget'],
//         };
//         currentUserPostList.add(currentUserPostData);
//       }
//     }
//   } catch (error) {
//     print('Error: $error');
//   }
//   return currentUserPostList;
// }

// class OffersInbox extends StatelessWidget {
 
//   const OffersInbox({Key? key, }) : super(key: key); // Change super.key to key

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchCurrentUserPostData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Text('No data found.');
//           } else {
//             final currentUserPostList = snapshot.data!;
//             final postLength = currentUserPostList.length;

//             return SizedBox(
//                 height: 270,
//                 width: double.infinity,
//                 child: ListView.builder(
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     itemCount: postLength,
//                     itemBuilder: (context, index) {
//                       // Removed the nested function
//                       if (currentUserPostList.isEmpty) {
//                         return const Text(
//                           'Hi',
//                           style: TextStyle(fontSize: 40, color: Colors.white),
//                         );
//                       } else {
//                         return Text(currentUserPostList[index]['contact']);
//                       }
//                     }));
//           }
//         });
//   }
// }