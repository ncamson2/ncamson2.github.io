import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vildi1/user_profile/profile_page.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';

/// This function will serve as the primary appbar and should be called through out the application
AppBar vildiAppBar(BuildContext context) {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color vildiGreen = Colors.white;
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
    FaIcon(
      (FontAwesomeIcons.home),
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
  final List<String> suggestions = [
    'ATV/BOAT/CAMPING',
    'ATV/BOAT/CAMPING',
    'FARM & GARDEN',
    'HEAVY EQUIPMENT',
    'JUMBLE BIN',
    'REAL ESTATE',
    'VEHICLES',
    'VEHICLES',
    'VEHICLES',
    'FARM & GARDEN',
  ];
  return AppBar(
    leading: Builder(builder: (BuildContext context) {
      return IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      );
    }),
    toolbarHeight: 80,
    // backgroundColor: Colors.transparent,
    title: Stack(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 19, 0, 10),
        child: Row(
          children: [
            Container(
              width: 80, // your desired width
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage(
                        '/Users/nickcamson/vildi1/lib/assets/vildi_white_see_thru.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Text('•   Vildi.com   •   What Are You Looking For?')
          ],
        ),
      ),
    ]),
    actions: [
      BlocBuilder<HomeNavCubit, HomeNavState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: vildiIcon.length,
            itemBuilder: (context, index) {
              return IconButton(
                icon: vildiIcon[index],
                onPressed: () {
                  if (index == 8) {
                    context.read<HomeNavCubit>().changeTab(tab: 0);
                  }
                  if (index == 9) {
                    context.read<HomeNavCubit>().changeTab(tab: 4);
                    //material route
                  } else if (index == index && index != 9) {
                    context
                        .read<ProductCubit>()
                        .selectedCategory(selectedCategory: suggestions[index]);
                    context.read<HomeNavCubit>().changeTab(tab: 0);
                    // context.read<HomeNavCubit>().changeTab(tab: 0);
                  }
                },
              );
            },
          );
        },
      ),
    ],
  );
}
