import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vildi1/bids/bids.dart';
import 'package:vildi1/cubit/bid_cubit.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/current_user_profile_cubit.dart';
import 'package:vildi1/product_profile_page/product_bid_page/product_bid_page.dart';
import 'package:vildi1/user_profile/profile_page.dart';
import 'package:vildi1/congrats/congrats.dart';
import 'package:vildi1/cubit/auth_cubit.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/cubit/pricetoggle_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';
import 'package:vildi1/farm_card/farm_card.dart';
import 'package:vildi1/firebase_options.dart';
import 'package:vildi1/login/login_page.dart';
import 'package:vildi1/main_body/main_body.dart';
import 'package:vildi1/search_post.dart/enter_product.dart';
import 'package:vildi1/side_nav/nav_drawer.dart';
import 'package:vildi1/side_nav/side_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vildi1/side_nav/vildi_app_bar.dart';
import 'package:vildi1/side_nav/what_is_vildi.dart';
import 'package:vildi1/user_profile/view_your_bids.dart';

import 'admin/contact_us.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductCubit>(
            create: (context) => ProductCubit(),
          ),
          BlocProvider<CurrentUserPostCubit>(
            create: (context) => CurrentUserPostCubit(),
          ),
          BlocProvider<CurrentUserProfileCubit>(
            create: (context) => CurrentUserProfileCubit(),
          ),
          BlocProvider<HomeNavCubit>(
            create: (context) => HomeNavCubit(),
          ),
          BlocProvider<PricetoggleCubit>(
            create: (context) => PricetoggleCubit(),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<BidCubit>(
            create: (context) => BidCubit(),
          ),

          //
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: LoginPage()
            // MyHomePage(
            //   title: '',
            // ),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                //! Change this please
                image: AssetImage(state.mainScreenBackgroundPhoto),
                fit: BoxFit.fill),
          ),
          child: Scaffold(
            appBar: vildiAppBar(context),

            // Drawer
            drawer: const NavigationDrawer1(),
            // Body with gradient background
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                  colors: [Colors.green, Colors.black],
                ),
              ),
              child: BlocBuilder<HomeNavCubit, HomeNavState>(
                builder: (context, state) {
                  return _buildBody(state.index);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    AuthStatus authStatus = context.read<AuthCubit>().state.status;
    String documentId = context.read<CurrentUserPostCubit>().state.productId;

    // List of indexes that should be scrollable
    final scrollableIndexes = [
      0,
      4
    ]; // Add or remove indexes based on your requirement

    Widget content;
    switch (index) {
      case 0:
        content = MainBody();
        break;
      case 1:
        content = const EnterProduct();
        break;
      case 2:
        content = const CongratsPage();
        break;
      case 3:
        content = const WhatIsVildi();
        break;
      case 4:
        content = ProfilePage();
        break;
      case 5:
        content = ProductBidPage();
        break;
      case 6:
        content = const BidPage();
        break;
      case 7:
        content = const ContactUs();
        break;
      case 8:
        content = const ViewYourBids();
        break;
      default:
        content = Container();
    }

    // If the current index is in the list of scrollable indexes, wrap the content in SingleChildScrollView
    return scrollableIndexes.contains(index)
        ? SingleChildScrollView(child: content)
        : content;
  }

  /// need to place build index fucntion here
}
