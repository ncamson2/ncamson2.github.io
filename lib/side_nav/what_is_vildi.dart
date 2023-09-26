import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vildi1/cubit/homenav_cubit.dart';

class WhatIsVildi extends StatelessWidget {
  const WhatIsVildi({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "VILDI",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
            const Text(
              "Connect your items to the people who value them",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.white,
              endIndent: 300,
              indent: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Vildi simplifies the buying and selling process by allowing prospective buyers to post wanted ads for specific items they are seeking. Sellers can then reach out directly to interested buyers when they come across an ad matching their offerings. It's a seamless and efficient platform that connects buyers and sellers, making transactions faster and more convenient.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "  Efficient and Targeted Connections \n The marketplace helps buyers and sellers connect quickly and easily by allowing buyers to specify their needs through wanted ads. Sellers can then find and reach out to interested buyers, reducing time wasted on irrelevant inquiries.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Increased Reach and Exposure \n Sellers gain wider visibility and exposure to potential buyers through the marketplace. They can explore numerous Wanted posts, reaching a larger market and increasing their chances of finding interested buyers for their items.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                " Streamlined Negotiations and Transactions \n  The platform simplifies the negotiation and transaction process. Sellers can directlycommunicate with interested buyers, eliminating the need for intermediaries. This direct interaction allows for efficient negotiations, clarification of details, and smoother transactions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FittedBox(
                //   fit: BoxFit.cover,
                //   child: SizedBox(
                //     child: Lottie.network(
                //       'https://assets2.lottiefiles.com/datafiles/AP6eAJ4K8cbfOl9/data.json',
                //       height: 100.0,
                //       repeat: false,
                //       reverse: true,
                //       animate: true,
                //     ),
                //   ),
                // ),
                Container(
                  height: 100, // Change this to your desired height
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<HomeNavCubit>().changeTab(tab: 0);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    child: const Text(
                      'See what Vildi has to offer!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
