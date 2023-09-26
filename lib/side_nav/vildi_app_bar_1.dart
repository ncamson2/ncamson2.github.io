import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/main.dart';
import 'package:vildi1/main_body/main_body.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The rational for making a new app bar here is to
/// ensure seperate of the functionality of the main app bar that handles
/// home navigation state controls.
AppBar vildiAppBar1(BuildContext context) {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color vildiGreen = Colors.black;
  List<FaIcon> vildiIcon = [
    FaIcon(
      (FontAwesomeIcons.ship),
      color: vildiGreen,
    ),
    FaIcon(
      (FontAwesomeIcons.campground),
      color: vildiGreen,
    ),
    FaIcon(
      (FontAwesomeIcons.tractor),
      color: vildiGreen,
    ),
    FaIcon(
      Icons.handyman,
      color: vildiGreen,
    ),
    FaIcon(
      Icons.book,
      color: vildiGreen,
    ),
    FaIcon(
      FontAwesomeIcons.shirt,
      color: vildiGreen,
      size: 20,
    ),
    FaIcon(
      Icons.real_estate_agent,
      color: vildiGreen,
      // size: 30,
    ),
    FaIcon(
      (FontAwesomeIcons.car),
      color: vildiGreen,
    ),
    // FaIcon(
    //   Icons.more_horiz,
    //   color: vildiGreen,
    // ),
    FaIcon(
      FontAwesomeIcons.circleUser,
      color: vildiGreen,
    ),
  ];
  return AppBar(
    leading: Builder(builder: (BuildContext context) {
      return IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(
          Icons.menu,
          color: Colors.black,
        ),
      );
    }),
    toolbarHeight: 80,
    backgroundColor: Colors.white,
    title: Stack(children: [
      Container(
        width: 170, // your desired width
        height: 80,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  '/Users/nickcamson/vildi1/lib/assets/new_logo.jpeg'),
              fit: BoxFit.fill),
        ),
      ),
    ]),
    actions: [
      BlocBuilder<HomeNavCubit, HomeNavState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: vildiIcon.length,
            itemBuilder: (context, index) {
              return IconButton(
                icon: vildiIcon[index],
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        title: '',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    ],
  );
}
