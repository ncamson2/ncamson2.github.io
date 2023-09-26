import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/bids/bid_gridview_display.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';

class ViewYourBids extends StatelessWidget {
  const ViewYourBids({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserPostCubit, CurrentUserPostState>(
        builder: (context, state) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      String productId = state.productId;
      print(productId + 'This is a test');
      return SizedBox(
        height: height,
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.fromLTRB(width / 10, 0, 0, 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       /// Thi should display the username of the person who in
            //       /// initially posted the vildi ad.
            //       // Text(
            //       //   'Poster Username: ${context.read<CurrentUserPostCubit>().state.username}',
            //       //   style: TextStyle(color: Colors.white, fontSize: 20),
            //       // ),
            //     ],
            //   ),
            // ),
            // Hero(
            //     tag: 'productBackgroundImage',
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: InkWell(
                                  onTap: () {
                                    // Put your onTap code here
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .transparent, // Making background transparent
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2), // Adding white border
                                    ),
                                    child: Text(
                                      'Edit Post',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// You need to have a condition where people can only plac e numbers
                          /// or if they put a dollar sign add a null check
                          /// I'm assuming theres a number textfiled widget in flutter
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              /// state.price or something ... go find it ...
                              "Your Maximum Price: \$${context.read<CurrentUserPostCubit>().state.productPrice}"
                              ' Dollars',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: CircleAvatar(
                            radius: width / 6,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: (width / 6) - 2,
                              backgroundImage:
                                  NetworkImage(state.productImageUrl),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        state.productName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (height * width / 22000),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height / 25,
                      ),
                      Container(
                          width: width / 2,
                          height: height / 1.6,
                          child: BidGridView()),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
