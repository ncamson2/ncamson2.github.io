import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/animations/typing_animation.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';
import 'package:vildi1/farm_card/farm_card.dart';
import 'package:vildi1/main_body/farm_post_list.dart';
import 'package:vildi1/main_body/main_category_list.dart';
import 'package:vildi1/main_body/search_row.dart';
import 'package:vildi1/models/products_model.dart';
import 'package:vildi1/product_profile_page/product_profile_page.dart';
import 'package:vildi1/search_post.dart/enter_product.dart';

// ignore: must_be_immutable

//! This class must be cleaned up ...
class MainBody extends StatelessWidget {
  MainBody({super.key});

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
  final List<String> categorynames = [
    'ATV',
    'BOAT',
    'FARM & GARDEN',
    'JUMBLE BIN',
    'REAL ESTATE',
    'HEAVY EQUIPMENT',
    'VEHICLES',
  ];
  // getData() async {
  //   final DocumentReference document = FirebaseFirestore.instance
  //       .collection('test')
  //       .doc('TbgCc5fYw4Cge9XAYoUF');

  //   final DocumentSnapshot snapshot = await document.get();

  //   if (snapshot.exists) {
  //     print('test_again field value:/Users/nickcamson/vildi1/lib/assets/vildi_white_see_thru.png ${snapshot.get('test_again')}');
  //   } else {
  //     print('Document does not exist');
  //   }
  // }

  Future<String> getTest() async {
    final DocumentReference document = FirebaseFirestore.instance
        .collection('test')
        .doc('TbgCc5fYw4Cge9XAYoUF');
    final DocumentSnapshot snapshot = await document.get();
    return snapshot.exists
        ? snapshot.get('test_again')
        : 'Document does not exist';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 100, 20),
              child: Text(
                'Looking To Sell?',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(100, 0, 0, 20),
              child: Text(
                'Wanting to Buy?',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        searchRow1(context),
        // Rest of your widgets go here

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Browse Vildi Wanted Ads',
                style: TextStyle(fontSize: 30, color: Colors.white),
              )
            ],
          ),
        ),
        // FutureBuilder<String>(
        //   future: getTest(), // The future function you want to call
        //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.none:
        //         return Text('Press button to start.');
        //       case ConnectionState.active:
        //       case ConnectionState.waiting:
        //         return Text('Awaiting result...');
        //       case ConnectionState.done:
        //         if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        //         return Text(
        //             'Result: ${snapshot.data}'); // If the future is complete and no errors occurred, display the created posts
        //     }
        //   },
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: SizedBox(
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: categoryImages.length,
              itemBuilder: (context, index) {
                return FarmCard(
                    image: categoryImages[index],
                    personName: categorynames[index],
                    productPrice: '',
                    posterId: 'test',
                    onTap: () {
                      context.read<ProductCubit>().selectedCategory(
                          selectedCategory: categorynames[index]);
                    });
              },
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: TypeWriter(
                text: 'Let Vidi Connect You To Buyers Who Value Your Goods!',
              ),
              // Text(
              //   'Let Vidi Connect You To Buyers Who Value Your Goods!',
              //   style: TextStyle(fontSize: 30, color: Colors.white),
              // ),
            )
          ],
        ),

        // SizedBox(
        //   height: 270,
        //   width: double.infinity,
        //   child: ListView.builder(
        //     physics: const AlwaysScrollableScrollPhysics(),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 8,
        //     itemBuilder: (context, index) {
        //       return
        //           // Hero(
        //           //   tag: 'productBackgroundImage',
        //           BlocBuilder<ProductCubit, ProductState>(
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

        //               print('hello wor');
        //             },
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: const [
        //     Padding(
        //       padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
        //       child: Text(
        //         'Browse by manufacturer',
        //         style: TextStyle(fontSize: 30, color: Colors.white),
        //       ),
        //     )
        //   ],
        // ),
        // Container(
        //   height: 270,
        //   width: double.infinity,
        //   child: ListView.builder(
        //     physics: const AlwaysScrollableScrollPhysics(),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 8,
        //     itemBuilder: (context, index) {
        //       return FarmCard(
        //           image: farmImages1[index],
        //           personName: productNames1[index],
        //           productPrice: '\$${productPrices[index]} dollars',
        //           posterId: 'test',
        //           onTap: () {});
        //     },
        //   ),
        // ),

        Padding(
          padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
          child: VerticalFarmPostDisplayList(),
        ),
      ],
    );
  }
}
