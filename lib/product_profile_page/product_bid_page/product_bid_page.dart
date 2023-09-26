import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/bids/bid_gridview_display.dart';
import 'package:vildi1/cubit/bid_cubit.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/cubit/pricetoggle_cubit.dart';
import 'package:vildi1/product_profile_page/offer_grid.dart';
import 'package:vildi1/product_profile_page/price_best_toggle.dart';
import 'package:vildi1/product_profile_page/product_bid_page/product_bid_big_screen.dart';
import 'package:vildi1/side_nav/vildi_app_bar.dart';

import '../../cubit/product_cubit.dart';

// ignore: must_be_immutable
class ProductBidPage extends StatelessWidget {
  // final String backgroundImage;
  // final String documentId;
  ProductBidPage({
    super.key,
    // required this.backgroundImage,
    // required this.documentId,
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

  /// this should also be a index stored in the navigation state and utalize a differnet app bar
  /// lets say it's index 6 or something ... delete these comments once that is done
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width);
    return ProductBidBigScreen();
  }
}
