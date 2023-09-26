import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vildi1/cubit/bid_cubit.dart';
import 'package:vildi1/cubit/current_user_post_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';
import 'package:vildi1/models/products_model.dart';

/// This will serve as the area for a user to upload
/// the information pertaining to the the bidding on a specific
/// product. These are textfields, but if they need to take
/// different types of data they will be able to
class BidTextFields extends StatefulWidget {
  const BidTextFields({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BidTextFieldsState createState() => _BidTextFieldsState();
}

class _BidTextFieldsState extends State<BidTextFields> {
  final _bidPriceController = TextEditingController();
  final _bidConditionController = TextEditingController();

  @override
  void initState() {
    /// we should probably use a differnt cubit here
    /// The purpose of this block of code and these functions is
    /// to store the state of information pertaining to a users bid
    super.initState();
    _bidPriceController.addListener(() {
      final String bidPriceText = _bidPriceController.text.replaceAll(',', '');

      try {
        final num bidPriceNum = num.parse(bidPriceText);
        context.read<BidCubit>().bidPrice(bidPrice: bidPriceNum);
      } catch (e) {
        // handle error - maybe show a message to the user?
      }

      // .bidProductPrice(productPrice: _bidPriceController.text);
    });
    _bidConditionController.addListener(() {
      context.read<BidCubit>().bidProductCondition(
          bidProductCondition: _bidConditionController.text);
    });
  }

  @override
  void dispose() {
    _bidPriceController.dispose();
    _bidConditionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.45;
    double height = 70;

    List<TextEditingController> vildiTextEditingControllers = [
      _bidPriceController,
      _bidConditionController,
    ];
    List<String> hintTexts = [
      'How many dollars would you sell the item for?',
      "What condition is the item in?",
    ];

    List<Widget> vildiIcon = [
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.boxOpen, color: Colors.white)),
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.box, color: Colors.white)),
    ];
    double width1 = MediaQuery.of(context).size.width;

    /// Probably have if index == 0 do soemthing else
    /// that should be the filled in drop down menu ...
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.transparent,
          width: width,
          height: height * 2.5,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hintTexts.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 1.14,
                      child: BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          return TextField(
                            controller: vildiTextEditingControllers[index],
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: vildiIcon[index],
                              alignLabelWithHint: true,
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.2),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                              hintText: hintTexts[index],
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 190, 190, 190)),
                            ),
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

  /// This widget needs to be greatly altered
  /// you shoudl not be allowed to typle in this box and
  /// when touched should bring up the catageroies
}
