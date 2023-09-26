import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';

class CongratsPage extends StatelessWidget {
  const CongratsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 4,
          ),
          Text(
            'Congrats, our team will review your post!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          SizedBox(
            height: height / 10,
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
                height: 160, // Change this to your desired height
                child: ElevatedButton(
                  onPressed: () {
                    context.read<HomeNavCubit>().changeTab(tab: 0);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  child: const Text(
                    'Continue browsing through Vildi!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
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
            ],
          ),
        ],
      ),
    );
  }
}
