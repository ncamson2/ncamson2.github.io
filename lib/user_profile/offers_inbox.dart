import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/farm_card/current_user_post_card.dart';
import 'package:vildi1/farm_card/farm_card.dart';

import '../cubit/product_cubit.dart';

/// the purpose of this widget is to actually display a specfic category.
/// The speicfic check I will be testing here is if the current user made the post
/// and a different user has placed a bid on the post 
/// This will tell the program to load data to the user that actually posted the content
//!
///The approach here is to store everything in stateand then have that information be displayed
/// Use a model here as well
/// CurrentUserPostModel or somethhing ...
class OffersInbox extends StatelessWidget {
  const OffersInbox({super.key});

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
              .where((offer) => offer['posterId'] == user && offer['hasBids'] == true)
              .toList();

          // context
          //     .read<CurrentUserPostCubit>()
          //     .postLength(postLength: currentUserPostDisplayed.length);

          final postLength = currentUserPostDisplayed.length;
          print(postLength);
          context
              .read<CurrentUserPostCubit>()
              .postLength(postLength: postLength);
          return SizedBox(
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: postLength, // Set itemCount dynamically
              itemBuilder: (context, index) {
                return BlocBuilder<CurrentUserPostCubit, CurrentUserPostState>(
                  builder: (context, state) {
                    // print(currentUserPostDisplayed.length);
                    // context.read<CurrentUserPostCubit>().postLength(
                    //     postLength: currentUserPostDisplayed.length);
                    // print(context
                    //         .read<CurrentUserPostCubit>()
                    //         .state
                    //         .postLength
                    //         .toString() +
                    //     'heyyy');
                    // Move the conditional logic here
                    if (currentUserPostDisplayed.isEmpty) {
                      return const Text(
                        'Hi',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      );
                    } else {
                      return CurrentUserPostCard(
                        image: currentUserPostDisplayed[index]
                            ['productImageUrl'],
                        productName: currentUserPostDisplayed[index]
                            ['productName'],
                        productPrice: currentUserPostDisplayed[index]
                            ['maximumPrice'],
                        posterId: currentUserPostDisplayed[index]['posterId'],
                        onTap: () {
                          print('hello nick');
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