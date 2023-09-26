import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vildi1/cubit/product_cubit.dart';
import 'package:vildi1/models/products_model.dart';

class ProductTextFieldWidget extends StatefulWidget {
  @override
  _ProductTextFieldWidgetState createState() => _ProductTextFieldWidgetState();
}

class _ProductTextFieldWidgetState extends State<ProductTextFieldWidget> {
  final _categoryController = TextEditingController();
  final _wantedNameController = TextEditingController();
  final _brandController = TextEditingController();
  final _yearManufacturedController = TextEditingController();
  final _productConditionController = TextEditingController();
  final _locationController = TextEditingController();
  final _maximumPriceController = TextEditingController();
  final _additionalNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _categoryController.addListener(() {
    //   context
    //       .read<ProductCubit>()
    //       .productPrice(productPrice: _categoryController.text);
    // });
    _wantedNameController.addListener(() {
      context
          .read<ProductCubit>()
          .productName(productName: _wantedNameController.text);
    });

    _brandController.addListener(() {
      context
          .read<ProductCubit>()
          .productDetails(productDetails: _brandController.text);
    });
    _yearManufacturedController.addListener(() {
      context.read<ProductCubit>().yearOfManufacture(
          yearOfManufacture: _yearManufacturedController.text);
    });
    _productConditionController.addListener(() {
      context
          .read<ProductCubit>()
          .conditionOfItem(conditionOfItem: _productConditionController.text);
    });
    _locationController.addListener(() {
      context.read<ProductCubit>().location(location: _locationController.text);
    });

    _maximumPriceController.addListener(() {
      context
          .read<ProductCubit>()
          .maximumPrice(maximumPrice: _maximumPriceController.text);
    });
    _maximumPriceController.addListener(() {
      context
          .read<ProductCubit>()
          .maximumPrice(maximumPrice: _maximumPriceController.text);
    });
    _additionalNotesController.addListener(() {
      context
          .read<ProductCubit>()
          .additionalNotes(additionalNotes: _additionalNotesController.text);
    });
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _wantedNameController.dispose();
    _brandController.dispose();
    _yearManufacturedController.dispose();
    _productConditionController.dispose();
    _locationController.dispose();
    _maximumPriceController.dispose();
    _maximumPriceController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.75;
    double height = 70;

    List<TextEditingController> vildiTextEditingControllers = [
      _categoryController,
      _wantedNameController,
      _brandController,
      _yearManufacturedController,
      _productConditionController,
      _locationController,
      _maximumPriceController,
      _additionalNotesController
    ];
    List<String> hintTexts = [
      'Category?',
      "Wanted Item?",
      'Brand/Model?',
      "Year Manufactured?",
      'Condition? (Leave blank if does not apply)',
      'Your General Location?',
      'Maximum Purchase Price?',
      'Additional Notes ...'
    ];
    List<String> hintTexts1 = [
      'Category?',
      "Wanted Item?",
      'Desired Location?',
      "Let Corbin and Nick Know!",
      'Let Corbin and Nick Know!',
      'Your Area Code?',
      'Maximum Purchase Price?',
      'Additional Notes ...'
    ];

    List<Widget> vildiIcon = [
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.boxOpen, color: Colors.white)),
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.box, color: Colors.white)),
      const Padding(
          padding: EdgeInsets.all(8.0),
          child:
              FaIcon(FontAwesomeIcons.brandsFontAwesome, color: Colors.white)),
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.calendar, color: Colors.white)),
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.newspaper, color: Colors.white)),
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.map, color: Colors.white)),
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.moneyBill, color: Colors.white)),
      const Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(FontAwesomeIcons.question, color: Colors.white)),
    ];
    double width1 = MediaQuery.of(context).size.width;

    /// Probably have if index == 0 do soemthing else
    /// that should be the filled in drop down menu ...
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.transparent,
          width: width / 1.5,
          height: height * 10,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hintTexts.length,
              itemBuilder: (context, index) {
                // print("Product Name: ${vildiTextEditingControllers[0].text}");
                return index == 0
                    ? searchRow(width, height)
                    : Column(
                        children: [
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          SizedBox(
                            width: width,
                            height: height * 1.14,
                            child: BlocBuilder<ProductCubit, ProductState>(
                              builder: (context, state) {
                                return TextField(
                                  controller:
                                      vildiTextEditingControllers[index],
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
                                    hintText: (context
                                                .read<ProductCubit>()
                                                .state
                                                .sendSelectedItemTotextfield ==
                                            'REAL ESTATE')
                                        ? hintTexts1[index]
                                        : hintTexts[index],
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 190, 190, 190)),
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
  searchRow(double width, double height) {
    final List<String> _suggestions = [
      'ATV/BOAT/CAMPING',
      'FARM & GARDEN',
      'HEAVY EQUIPMENT',
      'JUMBLE BIN',
      'REAL ESTATE',
      'VEHICLES',
    ];
    return SizedBox(
        height: height * 1.14,
        child: Row(children: [
          Container(
              color: Colors.transparent,
              width: width / 1.77,
              child: Theme(
                data: Theme.of(context).copyWith(
                  popupMenuTheme: PopupMenuThemeData(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color:
                              Colors.white), // White border for the entire menu
                      borderRadius: BorderRadius.circular(
                          4.0), // Optional: if you want rounded borders
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    double screenWidth = MediaQuery.of(context).size.width;
                    double menuWidth =
                        205; // Assuming the width of your menu is 200 pixels
                    RelativeRect position = RelativeRect.fromLTRB(
                      .02 * width,
                      205,
                      (.98 * width) - 205,
                      50,
                    );
                    // define the dropdown functionality here
                    final RenderBox button =
                        context.findRenderObject() as RenderBox;
                    final RenderBox overlay = Overlay.of(context)
                        .context
                        .findRenderObject() as RenderBox;
                    // final RelativeRect position = RelativeRect.fromRect(
                    //   Rect.fromPoints(
                    //       button.localToGlobal(Offset.zero, ancestor: overlay),
                    //       button.localToGlobal(
                    //           button.size.bottomRight(Offset.zero),
                    //           ancestor: overlay)),
                    //   Offset.zero & overlay.size,
                    // );
                    showMenu<String>(
                      context: context,
                      position: position,
                      items: _suggestions.map((String suggestion) {
                        // print(suggestion);

                        return PopupMenuItem<String>(
                          value: suggestion,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(
                                    8.0), // Add padding if needed

                                child: Text(
                                  suggestion,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                                endIndent: 50,
                                indent: 50,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                      elevation: 8.0,
                    ).then((String? selectedItem) {
                      if (selectedItem != null) {
                        print(context
                                .read<ProductCubit>()
                                .state
                                .sendSelectedItemTotextfield +
                            '1231');
                        print(selectedItem + '1212');
                        print(context
                            .read<ProductCubit>()
                            .state
                            .sendSelectedItemTotextfield);
                        context
                            .read<ProductCubit>()
                            .sendSelectedItemTotextfield(
                                sendSelectedItemTotextfield: selectedItem);
                        // Handle your functionality for selected item here
                      }
                    });
                  },
                  child: Container(
                    height: 50,

                    padding: const EdgeInsets.symmetric(
                        horizontal: 10), // Similar padding to TextField
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.2), // Fill color same as TextField
                      border: Border.all(
                        color: Colors.white, // Border color same as TextField
                        width: 2, // Border width same as TextField
                      ),
                      borderRadius: BorderRadius.circular(
                          4), // You can set this to match your TextField
                    ),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.search,
                            color: Colors.white), // Prefix icon
                        const SizedBox(
                            width: 10), // Space between the icon and text
                        BlocBuilder<ProductCubit, ProductState>(
                          builder: (context, state) {
                            return Text(
                              state.sendSelectedItemTotextfield,
                              style:
                                  TextStyle(color: Colors.white), // Text style
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 50,
            width: width / 10,
            child: Theme(
              data: Theme.of(context).copyWith(
                popupMenuTheme: PopupMenuThemeData(
                  color: Colors.transparent
                      .withOpacity(0.8), // Background color of the tiles
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color:
                            Colors.white), // White border for the entire menu
                    borderRadius: BorderRadius.circular(
                        4.0), // Optional: if you want rounded borders
                  ),
                ),
              ),
              child: Builder(builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    double screenWidth = MediaQuery.of(context).size.width;
                    double menuWidth =
                        205; // Assuming the width of your menu is 200 pixels
                    RelativeRect position = RelativeRect.fromLTRB(
                      .02 * width,
                      205,
                      (.98 * width) - 205,
                      50,
                    );
                    // define the dropdown functionality here
                    final RenderBox button =
                        context.findRenderObject() as RenderBox;
                    final RenderBox overlay = Overlay.of(context)
                        .context
                        .findRenderObject() as RenderBox;
                    // final RelativeRect position = RelativeRect.fromRect(
                    //   Rect.fromPoints(
                    //       button.localToGlobal(Offset.zero, ancestor: overlay),
                    //       button.localToGlobal(
                    //           button.size.bottomRight(Offset.zero),
                    //           ancestor: overlay)),
                    //   Offset.zero & overlay.size,
                    // );
                    showMenu<String>(
                      context: context,
                      position: position,
                      items: _suggestions.map((String suggestion) {
                        return PopupMenuItem<String>(
                          value: suggestion,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent.withOpacity(.3),
                                padding: const EdgeInsets.all(
                                    8.0), // Add padding if needed

                                child: Text(
                                  suggestion,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                                endIndent: 50,
                                indent: 50,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                      elevation: 8.0,
                    ).then((String? selectedItem) {
                      if (selectedItem != null) {
                        //! This is where the application picks up
                        //! state for posting vildi wanted ads
                        print('HEHLO');

                        context
                            .read<ProductCubit>()
                            .sendSelectedItemTotextfield(
                                sendSelectedItemTotextfield: selectedItem);
                        print(context
                                .read<ProductCubit>()
                                .state
                                .sendSelectedItemTotextfield +
                            '12');
                        print(selectedItem);
                        // Handle your functionality for selected item here
                      }
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.transparent;
                        }
                        return Colors
                            .transparent; // when button is in default or hover state
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                            color: Colors.white), // This is the white border
                      ),
                    ),
                  ),
                  child: const Icon(Icons.arrow_drop_down, color: Colors.white),
                );
              }),
            ),
          ),
        ]));
  }
}
