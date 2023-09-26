import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/pricetoggle_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';
import 'package:vildi1/product_profile_page/offer_grid.dart';
import 'package:vildi1/product_profile_page/price_best_toggle.dart';
import 'package:vildi1/side_nav/vildi_app_bar.dart';
import 'package:vildi1/side_nav/vildi_app_bar_1.dart';

// ignore: must_be_immutable
class ProductProfile extends StatelessWidget {
  final String backgroundImage;
  ProductProfile({
    super.key,
    required this.backgroundImage,
  });

  /// put a toggle switch here for people to toggle between best product and best price
  List<String> bids = [
    '1999',
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
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(state.productPhoto), fit: BoxFit.fill),
        ),
        child: Scaffold(
          appBar: vildiAppBar1(context),
          backgroundColor: Color.fromARGB(0, 87, 42, 42).withOpacity(.7),
          body: Column(
            children: [
              // Hero(
              //     tag: 'productBackgroundImage',
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "I have this item and I'd like to sell it!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30, // Setting font size to 30
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: CircleAvatar(
                            radius: width / 6,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: (width / 6) - 2,
                              backgroundImage: AssetImage(state.productPhoto),
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
                      PriceBestToggle(
                        height: height / 10,
                        width: width / 4,
                      ),
                      SizedBox(
                        height: height / 25,
                      ),
                      const Text(
                        'Let Us Connect Sellers With Buyers Who Value Your Goods!',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height / 20,
                      ),

                      /// Thye want this to check state and if the state is the
                      /// current user to have this be displayer, but if it is not
                      /// you should be displaying the alert dialogs info that you collect
                      /// This shouldnt be to crazy. Just use a model function to query 
                      /// the necessary data.
                      Container(
                        width: width / 2,
                        height: height / 1.6,
                        child: BlocBuilder<PricetoggleCubit, PricetoggleState>(
                          builder: (context, state) {
                            return _buildBody(state.index);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  /// This function will toggle between the two gridviews that are
  /// possible based on the data provided.
  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return OfferGrid();
      case 1:
        return OfferGrid();
      default:
        return Container();
    }
  }
}
