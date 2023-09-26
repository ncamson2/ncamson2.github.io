import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/farm_card/current_user_post_card.dart';
import 'package:vildi1/farm_card/farm_card.dart';

import '../cubit/product_cubit.dart';

/// the purpose of this widget is to actually display a specfic category.
/// The speicfic check I will be testing here is if the current user made the post
/// This will tell the program to load data to the user that actually posted the content
//!
///The approach here is to store everything in stateand then have that information be displayed
/// Use a model here as well
/// CurrentUserPostModel or somethhing ...
/// 
//! 
/// You probably should be just calling the subCollection myPosts here .
/// Actually, you obviosuly shouldd but im being lazy atm
class UserPostDisplay extends StatelessWidget {
  const UserPostDisplay({super.key});

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
              .where((offer) => offer['posterId'] == user)
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
                         context.read<HomeNavCubit>().changeTab(tab: 8);
                          print('hello nick');
                           print(currentUserPostDisplayed[index]['docId']);
                      
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
