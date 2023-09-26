import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';

class CurrentUserPostCard extends StatelessWidget {
  final String image;
  final String productName;
  final String productPrice;
  final String posterId;
  final void Function()? onTap;

  const CurrentUserPostCard({
    super.key,
    required this.image,
    required this.productName,
    required this.productPrice,
    required this.posterId,
    required this.onTap,
  });

  // Future<List<dynamic>> getLighting() async {
  //   final collectionRef = FirebaseFirestore.instance.collection('posts');
  //   // .orderBy('last_name',)

  //   final querySnapshot = await collectionRef
  //       .where('DJ', isEqualTo: true)
  //       // .orderBy('last_name', descending: true)
  //       .get();
  //   final documentId = querySnapshot.docs
  //       .map((doc) => '${doc['Lighting']}')
  //       .toList()
  //       .cast<String>();
  //   final firstLast = querySnapshot.docs
  //       .map((doc) => '${doc['first_name']}')
  //       .toList()
  //       .cast<String>();
  //   return [documentId, firstLast];
  // }
  // Should this function just be in a cubit
  // I'd create an entirely new list if i were you.
  // This fucntion needs to be used in a future builder.

  @override
  Widget build(BuildContext context) {
    // String imageUrl =
    //     'https://picsum.photos/250?random=${DateTime.now().millisecondsSinceEpoch}';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 250,
        width: 270,
        // This should be a media query or a layour builder ...
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 255,
                width: 270,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  color: Colors.white,
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.all(Radius.circular(25)),

                    /// This will sometimes be an assetImage and sometimes not be
                    /// I should probably set a bool somewhere in state saying what i need here
                    child: Image(
                      image: NetworkImage(
                          image), // Replace `Image.asset` with `NetworkImage`
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(.5),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(25))),
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Column(
                    children: [
                      // const Divider(
                      //   height: 1,
                      // ),
                      Expanded(
                        child: Text(
                          productName,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                      const Divider(
                          height: 1,
                          color: Colors.white,
                          endIndent: 110,
                          indent: 110),
                      Expanded(
                          child: Text(
                       '\$' + productPrice +' Dollars',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Container(
                width: 280,
                height: 255,
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
