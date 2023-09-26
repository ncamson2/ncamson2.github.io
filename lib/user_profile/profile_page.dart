import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/auth_cubit.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';
import 'package:vildi1/farm_card/farm_card.dart';
import 'package:vildi1/product_profile_page/product_profile_page.dart';
import 'package:vildi1/user_profile/accepted_offers_inbox.dart';
import 'package:vildi1/user_profile/offers_inbox.dart';
import 'package:vildi1/user_profile/offers_page.dart';
import 'package:vildi1/user_profile/placed_bid_display.dart';
import 'package:vildi1/user_profile/saved_posts.dart';
import 'package:vildi1/user_profile/user_post_display.dart';

/// formerly named signin page, but changed the name
/// because te name didn't reflect what this page did well
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  List<String> productNames = [
    'Tractor',
    'Harvester',
    'Plough',
    'Combine',
    'Seeder',
    'Mower',
    'Sprayer',
    'Cultivator',
    'Baler',
    'Hay Rake',
  ];
  List<String> productNames1 = [
    'Sprayer',
    'Cultivator',
    'Baler',
    'Hay Rake',
    'Tractor',
    'Harvester',
    'Plough',
    'Combine',
    'Seeder',
    'Mower',
  ];
  List<String> productPrices = [
    '1,723',
    '1,453',
    '5,900',
    '800',
    '5,300',
    '5,900',
    '800',
    '1,453',
  ];
  List<String> productPrices1 = [
    '22,700',
    '100,233',
    '7,876',
    '200,800',
    '5,300',
    '1216',
    '7,876',
    '200,800',
  ];
  List<String> farmImages = [
    '/Users/nickcamson/vildi1/lib/assets/tractor.jpg',
    '/Users/nickcamson/vildi1/lib/assets/harvestor.jpg',
    '/Users/nickcamson/vildi1/lib/assets/plough.jpg',
    '/Users/nickcamson/vildi1/lib/assets/farm_combine.jpg',
    '/Users/nickcamson/vildi1/lib/assets/seeder.jpg',
    '/Users/nickcamson/vildi1/lib/assets/sprayer.jpg',
    '/Users/nickcamson/vildi1/lib/assets/cultivator.jpg',
    '/Users/nickcamson/vildi1/lib/assets/baler.jpg'
  ];
  List<String> farmImages1 = [
    '/Users/nickcamson/vildi1/lib/assets/sprayer.jpg',
    '/Users/nickcamson/vildi1/lib/assets/cultivator.jpg',
    '/Users/nickcamson/vildi1/lib/assets/baler.jpg',
    '/Users/nickcamson/vildi1/lib/assets/tractor.jpg',
    '/Users/nickcamson/vildi1/lib/assets/harvestor.jpg',
    '/Users/nickcamson/vildi1/lib/assets/plough.jpg',
    '/Users/nickcamson/vildi1/lib/assets/farm_combine.jpg',
    '/Users/nickcamson/vildi1/lib/assets/seeder.jpg',
  ];

  List<String> categoryImages = [
    '/Users/nickcamson/vildi1/lib/assets/atv.jpg',
    '/Users/nickcamson/vildi1/lib/assets/boat.jpg',
    '/Users/nickcamson/vildi1/lib/assets/farm.jpg',
    '/Users/nickcamson/vildi1/lib/assets/antiques.jpg',
    '/Users/nickcamson/vildi1/lib/assets/cabin.jpg',
    '/Users/nickcamson/vildi1/lib/assets/sprayer.jpg',
    '/Users/nickcamson/vildi1/lib/assets/ford.jpg',
  ];

  @override
  // This should be an index on the home nev ...
  Widget build(BuildContext context) {
    String postLength =
        context.read<CurrentUserPostCubit>().state.postLength.toString();

    Size screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: screenSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              Center(
                child: Row(
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        String username = state.user.name;
                        return Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Text(
                            'Hello, $username!',
                            style: const TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.white,
                    //     radius: 52,
                    //     child: CircleAvatar(
                    //       radius: 50,
                    //       backgroundColor: Colors.green,
                    //       // backgroundImage: NetworkImage(
                    //       //   'https://picsum.photos/250?image=9',
                    //       // ), // Replace this URL with the user's profile image
                    //     ),
                    //   ),
                    // ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeNavCubit>().changeTab(tab: 1);
                        // Add Edit Profile functionality
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        primary: Colors.green, // Background color
                        onPrimary: Colors.white, // Foreground (text) color
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Post A Vildi Ad',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 40),
                    ElevatedButton(
                      onPressed: () {
                        // Add Edit Profile functionality
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12), // Foreground (text) color
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: BlocBuilder<CurrentUserPostCubit,
                            CurrentUserPostState>(
                          builder: (context, state) {
                            return Text(
                              '${state.postLength} Posts Made',
                              style: TextStyle(fontSize: 25),
                            );
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<CurrentUserPostCubit, CurrentUserPostState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            // Add Edit Profile functionality
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            primary: Colors.green, // Background color
                            onPrimary: Colors.white, // Foreground (text) color
                            side:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              state.acceptedOfferLength.toString() +
                                  ' Deals Made',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: screenSize.width / 40),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Divider(
                color: Colors.white,
                thickness: 5,
              ),
              const SizedBox(height: 16),

              /// This could potentially include a variable of the date/time
              /// the product was posted as well as other details.
              const Padding(
                padding: EdgeInsets.only(left: 100.0),

                /// Juts show that the user == user and bu =! null ...
                child: Text(
                  'Offers Inbox', // Replace with the actual email
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: OffersPlacedDisplay(),
              ),
              //  OffersInbox(),
              const Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: Text(
                  'Saved Vildi Ads', // Replace with the actual email
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: SavedPostsDisplay(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),

                /// i believe this is posts ... i have to ask Justin
                child: Padding(
                  padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: Text(
                    'My Vildi Ads',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: const UserPostDisplay(),
              ),

              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: Text(
                  "Products You've placed a bid on!", // Replace with the actual email
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: const BidsPlacedDisplay(),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: Text(
                  "Accepted Offers", // Replace with the actual email
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: AcceptedOffersDisplay(),
              )
              // SizedBox(
              //   height: 270,
              //   width: double.infinity,
              //   child: ListView.builder(
              //     physics: const AlwaysScrollableScrollPhysics(),
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 8,
              //     itemBuilder: (context, index) {
              //       /// A check should be placed here that if posterId == posterId ...
              //       /// or ifLiked return ...
              //       return BlocBuilder<ProductCubit, ProductState>(
              //         builder: (context, state) {
              //           /// The idea is that eventually this data will be dictated based on when things
              //           /// are posted as well as the category with simple bools showing what
              //           /// category the item is a part of
              //           return FarmCard(
              //             image: farmImages[index],
              //             personName: productNames[index],
              //             productPrice: '\$${productPrices1[index]} dollars',
              //             posterId: 'test',
              //             onTap: () {
              //               context
              //                   .read<ProductCubit>()
              //                   .productPhoto(productPhoto: farmImages[index]);
              //               context.read<ProductCubit>().productName(
              //                     productName: productNames[index],
              //                   );
              //               Navigator.of(context).push(
              //                 MaterialPageRoute(
              //                   builder: (context) => ProductProfile(
              //                       backgroundImage: state.productPhoto),
              //                 ),
              //               );
              //             },
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),

              /// the purpose of this widget is to actually display a specfici category
              /// lets put this in a seperate file
            ],
          ),
        ),
      ],
    );
  }
}
