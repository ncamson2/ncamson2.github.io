import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/bid_cubit.dart';
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
class OffersPlacedDisplay extends StatelessWidget {
  // final String categoryType;
  const OffersPlacedDisplay({
    super.key,
    // required this.categoryType,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: context.read<CurrentUserPostCubit>().fetchCurrentUserOfferData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data found.');
        } else {
          final currentUserBidList = snapshot.data!;
          // posterId should be something in state so you dont haev to keep
          // rewriting code for different parameters
          final currentUserBidDataDisplayed = currentUserBidList
              .where((offer) => offer['isAccepted'] == false)
              .

              /// where query to only show documents when the boolean is false
              toList();
          return currentUserBidDataDisplayed.isEmpty
              ? SizedBox(
                  height: 270,
                  width: 270,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        )),
                    child: const Center(
                      child: Text(
                        "You have no offers, we'll notify you when one is placed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 270,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: currentUserBidDataDisplayed
                        .length, // Set itemCount dynamically
                    itemBuilder: (context, index) {
                      return BlocBuilder<CurrentUserPostCubit,
                          CurrentUserPostState>(
                        builder: (context, state) {
                          print(currentUserBidDataDisplayed.length);
                          // Move the conditional logic here
                          if (currentUserBidDataDisplayed.length == 0) {
                            return const Text(
                              'Hi',
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white),
                            );
                          } else {
                            /// all of these parameters need to be stored in state
                            return CurrentUserPostCard(
                              image: currentUserBidDataDisplayed[index]
                                  ['bidImageUrl'],
                              productName: currentUserBidDataDisplayed[index]
                                  ['productName'],
                              productPrice: currentUserBidDataDisplayed[index]
                                          ['bidPrice']
                                      ?.toString() ??
                                  '0',
                              posterId: currentUserBidDataDisplayed[index]
                                  ['posterId'],
                              onTap: () {
                                /// This funciton should probbaly take the boolean
                                /// data type to accept/deny ... gotta think about how to switch
                                acceptDenyCunterOfferAlertDialog(context);

                                /// we want to store the information that we have already in state so they can be displayed
                                /// in the next page. However, we need to query additional information that will be related to
                                /// bids that will be querired in the bids subcollection which is nested in the producst collection
//!
                                /// Tbh ... for the mvp this should just be an accept bid button here
                                /// alert Dialog that says 'Buy product from username that posted it for xyz dollars and if they
                                /// hit yes an boughtProducts or soldProducts sub collection is created
                                ///
                                // context.read<HomeNavCubit>().changeTab(tab: 5);
                                context.read<CurrentUserPostCubit>().username(
                                    username: currentUserBidDataDisplayed[index]
                                        ['username']);
                                context.read<CurrentUserPostCubit>().posterId(
                                    posterId: currentUserBidDataDisplayed[index]
                                        ['posterId']);
                                context
                                    .read<CurrentUserPostCubit>()
                                    .productImageUrl(
                                      productImageUrl:
                                          currentUserBidDataDisplayed[index]
                                              ['bidImageUrl'],
                                    );
                                context
                                    .read<CurrentUserPostCubit>()
                                    .productName(
                                      productName:
                                          currentUserBidDataDisplayed[index]
                                              ['productName'],
                                    );
                                context
                                    .read<CurrentUserPostCubit>()
                                    .productPrice(
                                      productPrice:
                                          currentUserBidDataDisplayed[index]
                                                  ['bidPrice']
                                              .toString(),
                                    );
                                context.read<CurrentUserPostCubit>().productId(
                                    productId:
                                        currentUserBidDataDisplayed[index]
                                            ['productId']);

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

  Future<void> acceptDenyCunterOfferAlertDialog(BuildContext context) async {
    bool? isChecked = false;
    final state = context.read<BidCubit>().state;
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
                      'Here are the terms. Accept this offer?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                ),
                const Text(
                  'Item Name',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.read<CurrentUserPostCubit>().state.productName,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Sale Price',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$' +
                      context
                          .read<CurrentUserPostCubit>()
                          .state
                          .productPrice
                          .toString() +
                      " Dollars",
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Seller Username',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.read<CurrentUserPostCubit>().state.username,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                    backgroundImage: NetworkImage(context
                        .read<CurrentUserPostCubit>()
                        .state
                        .productImageUrl),
                  ),
                  // https://firebasestorage.googleapis.com/v0/b/vildi-2492e.appspot.com/o/images%2F0757d016a5c9fdb.jpeg?alt=media&token=0db2ed2b-e52e-4ce7-89ac-82ab164d9ff2
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Centers the buttons
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        /// The idea is to switch the bool to true here
                        /// This will allow you to have a new collection that
                        /// will be built on whether or not something
                        /// 'isAccepted'
                        context.read<CurrentUserPostCubit>().updateIsAccepted(
                            productId: context
                                .read<CurrentUserPostCubit>()
                                .state
                                .productId);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // foreground
                      ),
                      child: const Text(
                        'Accept',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String product = context
                            .read<CurrentUserPostCubit>()
                            .state
                            .productId;
                        context
                            .read<BidCubit>()
                            .deleteBidDetailsFromFirebasePostUsersCollection(
                                context, product);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red, // foreground
                      ),
                      child: const Text(
                        'Deny',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black, // foreground
                      ),
                      child: const Text(
                        'Message',
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
}
