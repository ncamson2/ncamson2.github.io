import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyBidList extends StatelessWidget {
  const EmptyBidList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // White color border
          width: 2, // Border width
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.network(
            'https://assets2.lottiefiles.com/datafiles/AP6eAJ4K8cbfOl9/data.json',
            height: 150.0,
            repeat: true,
            reverse: true,
            animate: true,
          ),
          SizedBox(
            height: 100,
          ),
          const Text(
            "No bids exist for this \n product, we'll notify you \n when a bid is placed!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
