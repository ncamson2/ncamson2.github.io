import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/bids/empty_bid_list.dart';
import 'package:vildi1/bids/product_extra_info.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/pricetoggle_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';

/// The puspose of this widget is to display infomation realting to the bids
/// that someone is placing on a product. It should be compiling a list of the documents
/// that is available in a specific products bid colection
class BidGridView extends StatelessWidget {
  BidGridView({super.key});
  List<String> cheapestPrice = [
    '2999',
    '2002',
    '2100',
    '2400',
    '4132',
    '4132',
    '4132',
  ];
  List<String> bestProductPrice = [
    '9219',
    '2002',
    '2100',
    '2400',
    '4132',
    '4132',
    '4132',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final user = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: context.read<CurrentUserPostCubit>().fetchUserBidData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            /// this is what will happen if the list is empty or null ...
            /// you should have this be a widget in a seperate file.
            /// maybe lottie crying face.
            return const EmptyBidList();
          } else {
            final currentUserPostList = snapshot.data!;
            // posterId should be something in state so you dont haev to keep
            // rewriting code for different parameters
            final currentUserPostDisplayed = currentUserPostList

                /// This works, but need a specific condition for when it actually is the user
                // .where((offer) => offer['docId'] != user)
                .toList();

          //   return currentUserPostDisplayed.isEmpty 
          // ? ProductExtraInfo() // Replace with your widget for empty condition
          // : 
          
          
         return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio:
                    (width / 2) / (height / 5), // 3 containers on its alignment
              ),
              itemCount: currentUserPostDisplayed.length,
              // 21 containers overall
              itemBuilder: (context, index) {
                return BlocBuilder<PricetoggleCubit, PricetoggleState>(
                  builder: (context, state) {
                    bool priceOrProduct = state.index == 0;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Transparent background
                          border: Border.all(
                            color: Colors.white, // White border
                            width: 2, // Border width
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: height / 15,
                                      child: CircleAvatar(
                                        radius: (height / 15) - 2,
                                        backgroundImage: NetworkImage(
                                          currentUserPostDisplayed[index]
                                              ['bidImageUrl'],
                                        ),
                                        //
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width / 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'Seller Username: ' +
                                            currentUserPostDisplayed[index]
                                                ['username'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),

                                /// This could potentially be a combination of the
                                /// attributes that aren't normally listed in clickable hashtags
                                /// you'd simply need to create a subcollection of tags here. Users
                                /// would then be able to browse products of a similar category

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'Product Tags: ' +
                                          currentUserPostDisplayed[index]
                                              ['bidProductCondition'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Text(
                                  state.index == 0
                                      ? 'Sale Price: '
                                          '${currentUserPostDisplayed[index]['bidPrice']} dollars'
                                      : 'Sale Price: '
                                          '${bestProductPrice[index]} dollars',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ), // White text
                                ),
                                const SizedBox()
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: height / 20,
                                    width: width / 8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // handle some logic first with a bool that if the user is
                                        // not authenticated it sends them to a sign up page.

                                        // Put your logic here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Colors.transparent, // Text color
                                        shadowColor: Colors
                                            .transparent, // Remove elevation shadow
                                        elevation: 0, // Remove elevation
                                        side: BorderSide(
                                            color: Colors.white,
                                            width: 2), // White border
                                      ),
                                      child: const Text('View Seller Info!'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: height / 20,
                                    width: width / 8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // handle some logic first with a bool that if the user is
                                        // not authenticated it sends them to a sign up page.

                                        // Put your logic here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Colors.transparent, // Text color
                                        shadowColor: Colors
                                            .transparent, // Remove elevation shadow
                                        elevation: 0, // Remove elevation
                                        side: BorderSide(
                                            color: Colors.white,
                                            width: 2), // White border
                                      ),
                                      child: const Text(
                                        'Accept This Offer!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        });
  }
}
