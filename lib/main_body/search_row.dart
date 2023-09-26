import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/cubit/product_cubit.dart';

Widget searchRow1(BuildContext context) {
  final List<String> _suggestions = [
    'ATV/BOAT/CAMPING',
    'FARM & GARDEN',
    'HEAVY EQUIPMENT',
    'JUMBLE BIN',
    'REAL ESTATE',
    'VEHICLES',
  ];
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceEvenly, // Centers the TextField and Button
    children: <Widget>[
      Row(
        children: [
          Container(
            color: Colors.transparent,
            width: .253333 * width,
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return _suggestions.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                // print('You just selected $selection');
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Colors
                        .transparent, // Ensure the material is transparent
                    elevation: 4.0,
                    child: Container(
                      height: 200,
                      width: width / 3,
                      child: ListView.builder(
                        padding:
                            EdgeInsets.zero, // This removes the default padding
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 16.0), // Padding for text

                                    child: Text(
                                      option,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 4),
                    ),
                    hintText: 'Browse a Category...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
            width:  57,
            child: Theme(
              data: Theme.of(context).copyWith(
                popupMenuTheme: PopupMenuThemeData(
                  color: Colors.transparent
                      .withOpacity(0.5), // Background color of the tiles
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
                        200; // Assuming the width of your menu is 200 pixels
                    RelativeRect position = RelativeRect.fromLTRB(
                      .11111333 * width,
                      180,
                      (screenWidth - menuWidth) / 2,
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
                        context
                            .read<ProductCubit>()
                            .selectedCategory(selectedCategory: selectedItem);
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
          SizedBox(
            height: 50,
            width: 57,
            child: ElevatedButton(
              onPressed: () {
                print(width);
                double screenWidth = MediaQuery.of(context).size.width;
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
              child: Image.asset(
                  '/Users/nickcamson/vildi1/lib/assets/vildi_white_see_thru.png'),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 50,
        width: width / 3,
        child: BlocBuilder<HomeNavCubit, HomeNavState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                // handle some logic first with a bool that if the user is
                // not authenticated it sends them to a sign up page.

                context.read<HomeNavCubit>().changeTab(tab: 1);
                // Put your logic here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent, // Text color
                shadowColor: Colors.transparent, // Remove elevation shadow
                elevation: 0, // Remove elevation
                side: const BorderSide(
                    color: Colors.white, width: 2), // White border
              ),
              child: const Text('Post a Vildi Ad!'),
            );
          },
        ),
      )
    ],
  );
}
