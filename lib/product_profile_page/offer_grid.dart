import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/pricetoggle_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';

class OfferGrid extends StatelessWidget {
  OfferGrid({super.key});
  List<String> cheapestPrice = [
    '1999',
    '2002',
    '2100',
    '2400',
    '4132',
    '4132',
    '4132',
  ];
  List<String> bestProductPrice = [
    '7219',
    '2002',
    '2100',
    '2400',
    '4132',
    '4132',
    '4132',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio:
            (width / 2) / (height / 5), // 3 containers on its alignment
      ),
      itemCount: 7,
      // 21 containers overall
      itemBuilder: (context, index) {
        return BlocBuilder<PricetoggleCubit, PricetoggleState>(
          builder: (context, state) {
            bool priceOrProduct = state.index == 0;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent, // Transparent background
                  border: Border.all(
                    color: Colors.white, // White border
                    width: 2, // Border width
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: height / 15,
                              child: CircleAvatar(
                                radius: (height / 15) - 2,
                                backgroundImage: AssetImage(context
                                    .read<ProductCubit>()
                                    .state
                                    .productPhoto),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width / 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Seller Username:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),

                        /// This could potentially be a combination of the
                        /// attributes that aren't normally listed in clickable hashtags
                        /// you'd simply need to create a subcollection of tags here. Users
                        /// would then be able to browse products of a similar category

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Product tags: ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        Text(
                          state.index == 0
                              ? 'Sale Price: ' '${cheapestPrice[index]} dollars'
                              : 'Sale Price: '
                                  '${bestProductPrice[index]} dollars',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ), // White text
                        ),
                        const SizedBox()
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: height / 20,
                            width: width / 8,
                            child: ElevatedButton(
                              onPressed: () {
                                // handle some logic first with a bool that if the user is
                                // not authenticated it sends them to a sign up page.

                                // Put your logic here
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Colors.transparent, // Text color
                                shadowColor: Colors
                                    .transparent, // Remove elevation shadow
                                elevation: 0, // Remove elevation
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 2), // White border
                              ),
                              child: const Text('View Seller Info!'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: height / 20,
                            width: width / 8,
                            child: ElevatedButton(
                              onPressed: () {
                                // handle some logic first with a bool that if the user is
                                // not authenticated it sends them to a sign up page.

                                // Put your logic here
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Colors.transparent, // Text color
                                shadowColor: Colors
                                    .transparent, // Remove elevation shadow
                                elevation: 0, // Remove elevation
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 2), // White border
                              ),
                              child: const Text('Send Seller A Message!'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            
          },
        );
      },
    );
  }
}
