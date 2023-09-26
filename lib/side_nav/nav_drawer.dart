import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicons/unicons.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';

import '../main.dart';

class NavigationDrawer1 extends StatelessWidget {
  const NavigationDrawer1({super.key});

  get assets => null;

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.black
              ], // Adjust the colors as per your preference
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.red,
        padding:
            const EdgeInsets.only(left: 20, top: 50, right: 20, bottom: 10),
        child: Column(children: const [
          CircleAvatar(
            radius: 52,
            // backgroundImage: AssetImage(
            //     '/Users/nickcamson/drawer_app/lib/assets/kevin.jpeg'),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 12),
          Text(
            'jhjh',
            style: TextStyle(fontSize: 20, fontFamily: 'Times New Roman'),
          ),
          Text(
            '',
            style: TextStyle(fontSize: 16, fontFamily: 'Times New Roman'),
          ),
        ]),
      );

  Widget buildMenuItems(BuildContext context) => Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 30,
            ),
            ListTile(
                leading: const Icon(
                  Icons.home_outlined,
                  size: 20,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Times New Roman',
                    color: Colors.white,
                  ),
                ),
                iconColor: Colors.white,
                textColor: Colors.white,
                onTap: () {
                  context.read<HomeNavCubit>().changeTab(tab: 0);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                  size: 20,
                ),
                title: const Text(
                  'Favorites',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Times New Roman',
                    color: Colors.white,
                  ),
                ),
                iconColor: Colors.white,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const FavoritesPage(),
                  //   ),
                  // );
                }),
            const Divider(color: Colors.white),
            ListTile(
                leading: const FaIcon(FontAwesomeIcons.question),
                title: const Text('What is Vildi'),
                iconColor: Colors.white,
                textColor: Colors.white,
                onTap: () {
                  context.read<HomeNavCubit>().changeTab(tab: 3);
                  Navigator.pop(context);

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const WorkPage(),
                  //   ),
                  // );
                }),
            ListTile(
                leading: const FaIcon(FontAwesomeIcons.hammer),
                title: const Text('How to use Vildi'),
                iconColor: Colors.white,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const UpdatePage(),
                  //   ),
                  // );
                }),
            ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Contact us'),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () {
                  context.read<HomeNavCubit>().changeTab(tab: 7);
                  Navigator.pop(context);
                }),
          ]);
}
