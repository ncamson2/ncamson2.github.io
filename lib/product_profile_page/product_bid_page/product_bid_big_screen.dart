import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/bids/bid_gridview_display.dart';
import 'package:vildi1/bids/bid_image_upload.dart';
import 'package:vildi1/bids/bid_submit_button.dart';
import 'package:vildi1/bids/bid_textfields.dart';
import 'package:vildi1/bids/extra_info_ui.dart';
import 'package:vildi1/bids/product_extra_info.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/cubit/pricetoggle_cubit.dart';
import 'package:vildi1/product_profile_page/offer_grid.dart';
import 'package:vildi1/product_profile_page/price_best_toggle.dart';
import 'package:vildi1/product_profile_page/save_post_button.dart';

class ProductBidBigScreen extends StatelessWidget {
  const ProductBidBigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserPostCubit, CurrentUserPostState>(
        builder: (context, state) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      String productId = state.productId;
      print(productId + 'hey nick');
      return SizedBox(
        height: height,
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(left: width / 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       /// Thi should display the username of the person who in
            //       /// initially posted the vildi ad.
            //       Text(
            //         'Poster Username: ${context.read<CurrentUserPostCubit>().state.username}',
            //         style: TextStyle(color: Colors.white, fontSize: 20),
            //       ),
            //     ],
            //   ),
            // ),
            // Hero(
            //     tag: 'productBackgroundImage',
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
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
                              "Buyer's Maximum Price: \$${context.read<CurrentUserPostCubit>().state.productPrice}"
                              ' Dollars',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      SavePostButton(
                        height: 100,
                        width: 300,
                      ),
                      //! Save button here
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Container(
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: Colors.white,
                      //           width: 2,
                      //         ),
                      //       ),
                      //       child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           padding: const EdgeInsets.all(8.0),
                      //           backgroundColor: Colors.transparent
                      //               .withOpacity(.1), // Background color
                      //           textStyle: const TextStyle(
                      //             fontSize: 30, // Setting font size to 30
                      //           ),
                      //         ),

                      //         /// This needs to take the state of the product id, the user as well
                      //         /// as information pertaining to the bid that you'd like stored in
                      //         /// the secondary firestore collection
                      //         onPressed: () {
                      //           print(productId + '67676');

                      //           /// You can either material route or change the home index
                      //           /// my personal opinion is that you should just be changing
                      //           /// the tab of the home index
                      //           context.read<HomeNavCubit>().changeTab(tab: 6);
                      //           //! This is the function that uploads data and should
                      //           //! be moved to a differnet page and was only for
                      //           //! display purposes only
                      //           // context
                      //           //     .read<BidCubit>()
                      //           //     .writeProductDetailsToFirebase(context);

                      //           // Your action here
                      //         },
                      //         child: const Padding(
                      //           padding: EdgeInsets.all(8.0),
                      //           child: Text(
                      //             "I have this item and I'd like to sell it!",
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //       )),
                      // ),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      /// This has to use the state of the username of the poster at a minimum.
                       Text(
                        'More Details From Your Potential Buyer ...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                            height: 250, width: 700, child: ExtraInfoUi()),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Text(
                          'Have this item?',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),

                      const BidTextFields(),

                      // SizedBox.expand(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child:
                                // you need to be passing different parameters
                                // through this like width and height based on
                                // a media query.
                                BidImageUpload(
                                    // height: 100,
                                    // width: width * .25 ,
                                    ),
                          ),
                        ],
                      ),
                      // bidSubmitButton(context, 1, 5.65),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.white,
                        height: 2,
                        width: 500,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                     
                      // Text('Put Vildi terms and conditions here?'),
                      // SizedBox(
                      //   height: 50,
                      // ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     SizedBox(
                  //       height: height / 25,
                  //     ),
                  //     PriceBestToggle(
                  //       height: height / 10,
                  //       width: width / 4,
                  //     ),
                  //     SizedBox(
                  //       height: height / 25,
                  //     ),
                  //     SizedBox(
                  //       height: height / 20,
                  //     ),
                  //     Container(
                  //       width: width / 2,
                  //       height: height / 1.6,
                  //       child: BlocBuilder<PricetoggleCubit, PricetoggleState>(
                  //         builder: (context, state) {
                  //           return _buildBody(state.index);
                  //         },
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 30,
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return ExtraInfoUi();
      case 1:

        /// you want to replace one of
        /// these with bids and it shold also have
        /// an action that will occur if the length
        /// is equal to zero/null
        return OfferGrid();
      default:
        return Container();
    }
  }
}
