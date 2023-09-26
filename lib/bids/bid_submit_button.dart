import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/bid_cubit.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';

Row bidSubmitButton(
  BuildContext context,
  double width1,
  double height1,
) {
  double width = MediaQuery.of(context).size.width * 0.75;
  double height = 50;
  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.transparent.withOpacity(.2), // Text color
    shadowColor: Colors.transparent, // Remove elevation shadow
    elevation: 0, // Remove elevation
    side: BorderSide(color: Colors.white, width: 2), // White border
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          SizedBox(
            height: width1,
            // * 5.65,
            width: height1,
            //  1.82,
            child: BlocBuilder<BidCubit, BidState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    print(state.bidPrice);
                    print(state.bidProductCondition);
                    print(state.bidImageUrl);
                    print(context.read<CurrentUserPostCubit>().state.posterId +
                        'hello nick');

                    productAlertDialogConfirm(context);
                  },
                  child: const Text(
                    'Preview Post Submission',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ],
  );
}

Future<void> productAlertDialogConfirm(BuildContext context) async {
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
                    'Review Post Details',
                    // 'Our team reviews posts before \n making them public to ensure \n they adhere to our company policy. \n Would you like to submit the below \n information to our team?',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 20),
              const Divider(
                color: Colors.black,
                indent: 10,
                endIndent: 10,
              ),
              SizedBox(height: 20),
              const Text(
                'Bid Price',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.bidPrice.toString(),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Product Condtion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.bidProductCondition,
                textAlign: TextAlign.center,
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
                  backgroundImage: NetworkImage(state.bidImageUrl),
                ),
                // https://firebasestorage.googleapis.com/v0/b/vildi-2492e.appspot.com/o/images%2F0757d016a5c9fdb.jpeg?alt=media&token=0db2ed2b-e52e-4ce7-89ac-82ab164d9ff2
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Centers the buttons
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // foreground
                    ),
                    child: const Text(
                      'No',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      /// this will write the deatils to firebase, but does not post them.
                      /// It's a business decision to decide if these 'posts' should be reviewed
                      /// before posting
                      context
                          .read<BidCubit>()
                          .writeProductDetailsToFirebase(context);
                      context
                          .read<BidCubit>()
                          .writeBidDetailsToFirebaseCurrentUsersCollection(
                              context);
                      context
                          .read<BidCubit>()
                          .writeBidDetailsToFirebasePostUsersCollection(
                              context);
                      print('HERE');

                      //! I would like to place an additional fucntion and subCollection here
                      //! concerning if any bids have been placed.

                      Navigator.pop(context);
                      context.read<HomeNavCubit>().changeTab(tab: 2);
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const CongratsPage(),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // foreground
                    ),
                    child: const Text(
                      'Submit!',
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
