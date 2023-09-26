import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/product_cubit.dart';

/// The originla purpose of this widget was to upload product images,
/// however, with a few tweaks of sizing and functionality it
/// could be used on the bidding side as well.
class ImageUpload extends StatefulWidget {
  final double width;
  final double height;

  const ImageUpload({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
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
          height: height * 6,
          width: width * .25,
          child: ElevatedButton(
            style: buttonStyle1,
            onPressed: () {
              print(height);
              print(width);
              context.read<ProductCubit>().uploadProductImageToFirebase();
            },
            child: const Text(
              'Upload an image',
            ),
          ),
        ),
        SizedBox(
          width: width / 20,
        ),
        SizedBox(
          height: height * 6,
          width: width * .25,
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              setState(() {
                isButtonTapped = !isButtonTapped;
              });
              print(isButtonTapped);
              context
                  .read<ProductCubit>()
                  .isWantingImageFromUs(isWantingImageFromUs: isButtonTapped);
              // isWantingImageFromUs
            },
            child: const Text(
              'Let AI Do It For Me',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
