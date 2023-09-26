// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';

// // Should a function like this be handled in a cubit and
// // written in one line in the file your trying to place it. 
// void writeProductDetailsToFirebase(
//   // you need to pass a few parameters through here like
//   // the controller name.
// ) async {
//   String getRandomString(int length) {
//     const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
//     Random rnd = Random();
//     String result = '';
//     for (var i = 0; i < length; i++) {
//       result += chars[rnd.nextInt(chars.length)];
//     }
//     return result;
//   }

//   String randomDoc = getRandomString(20);

//   final email = _emailController.text.trim();
//   final password = _passwordController.text.trim();

//   // Create a new user with the email and password.

//   // Add the user to the database.
//   final usersCollection = FirebaseFirestore.instance.collection('products');
//   final userDocument = await usersCollection.doc(randomDoc).set({
//     'venue_name': _venueNameController.text.trim(),
//     // 'last_name': _lastNameController.text.trim(),
//     'email': email,
//   });
// }
