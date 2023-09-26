import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
class FarmPostDisplay extends StatelessWidget {
  final String categoryType;
  const FarmPostDisplay({
    super.key,
    required this.categoryType,
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
          return const Text('No data found.');
        } else {
          final currentUserPostList = snapshot.data!;
          // posterId should be something in state so you dont haev to keep
          // rewriting code for different parameters
          final currentUserPostDisplayed = currentUserPostList
              .where((offer) =>
                  offer['productCategory'] == categoryType &&
                  offer['posterId'] != user)
              .toList();

          return SizedBox(
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount:
                  currentUserPostDisplayed.length, // Set itemCount dynamically
              itemBuilder: (context, index) {
                return BlocBuilder<CurrentUserPostCubit, CurrentUserPostState>(
                  builder: (context, state) {
                    print(currentUserPostDisplayed.length);
                    // Move the conditional logic here
                    if (currentUserPostDisplayed.length == 0) {
                      return const Text(
                        'Hi',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      );
                    } else {
                      /// all of these parameters need to be stored in state
                      return CurrentUserPostCard(
                        image: currentUserPostDisplayed[index]
                            ['productImageUrl'],
                        productName: currentUserPostDisplayed[index]
                            ['productName'],
                        productPrice: currentUserPostDisplayed[index]
                            ['maximumPrice'],
                        posterId: currentUserPostDisplayed[index]['posterId'],
                        onTap: () {
                          /// we want to store the information that we have already in state so they can be displayed
                          /// in the next page. However, we need to query additional information that will be related to
                          /// bids that will be querired in the bids subcollection which is nested in the producst collection
                          print(currentUserPostDisplayed[index]['docId']);
                          /// Name of file here: ProductBidPage
                          context.read<HomeNavCubit>().changeTab(tab: 5);
                          print(currentUserPostDisplayed[index]['posterId'] +
                              'ado');

                          context.read<CurrentUserPostCubit>().username(
                              username: currentUserPostDisplayed[index]
                                  ['posterId']);
                          print(state.posterId + 'test23');
                          context.read<CurrentUserPostCubit>().productImageUrl(
                                productImageUrl: currentUserPostDisplayed[index]
                                    ['productImageUrl'],
                              );
                          context.read<CurrentUserPostCubit>().productName(
                                productName: currentUserPostDisplayed[index]
                                    ['productName'],
                              );
                          context.read<CurrentUserPostCubit>().productPrice(
                                productPrice: currentUserPostDisplayed[index]
                                    ['maximumPrice'],
                              );
                          context.read<CurrentUserPostCubit>().productId(
                              productId: currentUserPostDisplayed[index]
                                  ['docId']);

                          print('heyyyyyy');
                        },
                      );
                    }
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
