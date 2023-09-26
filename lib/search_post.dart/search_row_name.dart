import 'package:flutter/material.dart';

class SearchRowWidget extends StatelessWidget {
  final double width;
  final double height;
  final List<String> _suggestions = [
    'ATV/BOAT/CAMPING',
    'FARM & GARDEN',
    'HEAVY EQUIPMENT',
    'JUMBLE BIN',
    'REAL ESTATE',
    'VEHICLES',
  ];

  SearchRowWidget({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 1.14,
      child: Row(
        children: [
          buildSearchContainer(context),
          buildDropdownButton(context),
        ],
      ),
    );
  }

  Widget buildSearchContainer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: width / 1.77,
      child: GestureDetector(
        onTap: () => _showPopup(context),
        child: buildStyledContainer(
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.white),
              SizedBox(width: 10),
              Text('Select a Category...', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width / 10,
      child: ElevatedButton(
        onPressed: () => _showPopup(context),
        style: buildButtonStyle(),
        child: const Icon(Icons.arrow_drop_down, color: Colors.white),
      ),
    );
  }

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Colors.transparent;
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildStyledContainer({required Widget child}) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }

  void _showPopup(BuildContext context) {
    // ... Remaining code for showing the menu.
    // This part can be refactored into its own method if needed
  }
}
