import 'package:flutter/material.dart';
import 'package:vildi1/bids/bid_image_upload.dart';
import 'package:vildi1/bids/bid_submit_button.dart';
import 'package:vildi1/bids/bid_textfields.dart';
import 'package:vildi1/search_post.dart/product_textfields.dart';
import 'package:vildi1/search_post.dart/submit_button.dart';
import 'package:vildi1/search_post.dart/upload_image.dart';

/// This page will serve to display the information in
/// a simplified manner.
/// This should be what is routed to with home index 7.
class BidPage extends StatelessWidget {
  const BidPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 40,
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
          bidSubmitButton(context, 1, 5.65),
          SizedBox(
            height: 50,
          ),
          Text('Put Vildi terms and conditions here?'),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
