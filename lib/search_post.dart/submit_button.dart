import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/product_cubit.dart';

Row submitButton(
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
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: height * height1,
            // * 5.65,
            width: width / width1,
            //  1.82,
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    print(state.productName);
                    print(state.productPrice);
                    print(state.productDetails);
                    context
                        .read<ProductCubit>()
                        .productAlertDialogConfirm(context);
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
