import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/animations/typing_animation.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/farm_card/current_user_post_card.dart';
import 'package:vildi1/farm_card/farm_card.dart';

import '../cubit/product_cubit.dart';
import '../product_profile_page/product_bid_page/product_bid_page.dart';

/// the purpose of this widget is to actually display a specfic category.
/// The speicfic check I will be testing here is if the current user made the post
/// This will tell the program to load data to the user that actually posted the content
//!
///The approach here is to store everything in stateand then have that information be displayed
/// Use a model here as well
/// CurrentUserPostModel or somethhing ...
//!
// I think you want to make a list here that displays all the categories amd
// place them in state. Tbh do them all and then ask justin and amanda the order
class ProductExtraInfo extends StatelessWidget {
  const ProductExtraInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: context.read<CurrentUserPostCubit>().fetchCurrentUserPostData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data found.',
              style: TextStyle(color: Colors.white));
        } else {
          final currentUserPostList = snapshot.data!;
          final currentUserPostDisplayed = currentUserPostList
              .where((offer) =>
                  offer['docId'] ==
                  context.read<CurrentUserPostCubit>().state.productId)
              .toList();

          // Map to hold the labels and values
          final Map<String, String> data = {
            // 'Product Category': currentUserPostDisplayed[0]['productCategory'] ?? '',
            'Product Brand': currentUserPostDisplayed[0]['productModel'] ?? '',
            // 'Year Manufactured': currentUserPostDisplayed[0]['productCategory'] ?? '',
            'Product Condition':
                currentUserPostDisplayed[0]['productCondition'] ?? '',
            'General Location':
                currentUserPostDisplayed[0]['buyerLocation'] ?? '',
            'Additional Notes':
                currentUserPostDisplayed[0]['productCategory'] ?? '',
            // 'posterUsername': currentUserPostDisplayed[0]['posterUsername'] ?? '',
          };

          return Column(
            children: [
              SizedBox(
                height: 250,
                width: 700,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        4, // adjust this to control height vs width
                    mainAxisSpacing: 4, // Vertical spacing
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String key = data.keys.elementAt(index);
                    return Container(
                      // height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2, // Width of the border
                        ),
                        borderRadius: BorderRadius.circular(12), // Optional
                      ),
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            Text(
                              key,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              data[key]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
