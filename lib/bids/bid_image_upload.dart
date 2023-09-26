import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/bids/bid_submit_button.dart';
import 'package:vildi1/cubit/bid_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';

class BidImageUpload extends StatefulWidget {
  // final double width;
  // final double height;

  const BidImageUpload({
    Key? key,
    // required this.width,
    // required this.height,
  }) : super(key: key);

  @override
  State<BidImageUpload> createState() => _BidImageUploadState();
}

class _BidImageUploadState extends State<BidImageUpload> {
  bool isButtonTapped = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.75;
    double height = 50;

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: isButtonTapped ? Colors.black : Colors.white,
      backgroundColor: isButtonTapped
          ? Colors.white.withOpacity(0.8)
          : Colors.transparent.withOpacity(.2),
      shadowColor: Colors.transparent,
      elevation: 0,
      side: BorderSide(
        color: isButtonTapped ? Colors.black : Colors.white,
        width: 2,
      ),
    );
    ButtonStyle buttonStyle1 = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent.withOpacity(.2), // Text color
      shadowColor: Colors.transparent, // Remove elevation shadow
      elevation: 0, // Remove elevation
      side: BorderSide(color: Colors.white, width: 2), // White border
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 2,
          width: width * .275,
          child: ElevatedButton(
            style: buttonStyle1,
            onPressed: () {
              print(height);
              print(width);
              context.read<BidCubit>().uploadProductImageToFirebase();
            },
            child: const Text(
              'Upload an image',
            ),
          ),
        ),
        SizedBox(
          width: width / 20,
        ),
        bidSubmitButton(
          context,
          height * 2,
          width * .275,
        )

        /// Preview post submission here ...
        // SizedBox(
        //   height: height * 2,
        //   width: width * .175,
        //   child: ElevatedButton(
        //     style: buttonStyle,
        //     onPressed: () {
        //       setState(() {
        //         isButtonTapped = !isButtonTapped;
        //       });
        //       print(isButtonTapped);
        //       context
        //           .read<ProductCubit>()
        //           .isWantingImageFromUs(isWantingImageFromUs: isButtonTapped);
        //       // isWantingImageFromUs
        //     },
        //     child: const Text(
        //       'Let The Vildi Team do it for me!',
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
