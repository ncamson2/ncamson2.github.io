import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/pricetoggle_cubit.dart';
import 'package:vildi1/product_profile_page/save_post_button.dart';

/// The purpose of these buttons are to toggle between
/// the two filters in the individual product section.
class PriceBestToggle extends StatelessWidget {
  final double height;
  final double width;
  const PriceBestToggle({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricetoggleCubit, PricetoggleState>(
      builder: (context, state) {
        return Row(
          children: [
            // Container(
            //   height: height,
            //   width: width * (2 / 3),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         context.read<PricetoggleCubit>().changeTab(tab: 0);
            //         print(state.index);
            //       },
            //       style: ElevatedButton.styleFrom(
            //         foregroundColor: Colors.white,
            //         backgroundColor:
            //             state.index == 0 ? Colors.white : Colors.transparent,
            //         // Text color
            //         shadowColor: Colors.transparent, // Remove elevation shadow
            //         elevation: 0, // Remove elevation
            //         side: BorderSide(
            //             color: state.index == 0 ? Colors.black : Colors.white,
            //             width: 2), // White border
            //       ),
            //       child: Text(
            //         'Cheapest Price',
            //         style: TextStyle(
            //           color: state.index == 0 ? Colors.black : Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   height: height,
            //   width: width * (2 / 3),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         context.read<PricetoggleCubit>().changeTab(tab: 1);
            //         print(state.index);
            //       },
            //       style: ElevatedButton.styleFrom(
            //         foregroundColor: Colors.white,
            //         backgroundColor: state.index == 1
            //             ? Colors.white
            //             : Colors.transparent, // Text color
            //         shadowColor: Colors.transparent, // Remove elevation shadow
            //         elevation: 0, // Remove elevation
            //         side: BorderSide(
            //             color: state.index == 1 ? Colors.black : Colors.white,
            //             width: 2), // White border
            //       ),
            //       child: Text(
            //         'Best Product',
            //         style: TextStyle(
            //           color: state.index == 1 ? Colors.black : Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SavePostButton(
              height: height,
              width: width * (2 / 3),
            )
          ],
        );
      },
    );
  }
}
