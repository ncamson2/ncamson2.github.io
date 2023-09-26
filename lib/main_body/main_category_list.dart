import 'package:flutter/material.dart';
import 'package:vildi1/main_body/farm_post_list.dart';

class VerticalFarmPostDisplayList extends StatelessWidget {
  VerticalFarmPostDisplayList({super.key});

  List<String> categorgyTypeList = [
    'HEAVY EQUIPMENT',
    'FARM & GARDEN',
    'JUMBLE BIN',
    'ATV/BOAT/CAMPING',
    'REAL ESTATE',
    'VEHICLES',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330 * 6,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        categorgyTypeList[index],
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ],
                ),
              ),
              FarmPostDisplay(
                categoryType: categorgyTypeList[index],
              ),
            ],
          ); // Your FarmPostDisplay widget
        },
        physics:
            const AlwaysScrollableScrollPhysics(), // Add scroll physics if needed
      ),
    );
  }
}
