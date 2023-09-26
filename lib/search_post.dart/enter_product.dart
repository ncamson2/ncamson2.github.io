import 'package:flutter/material.dart';
import 'package:vildi1/search_post.dart/product_textfields.dart';
import 'package:vildi1/search_post.dart/submit_button.dart';
import 'package:vildi1/search_post.dart/upload_image.dart';

class EnterProduct extends StatelessWidget {
  const EnterProduct({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //    double width = MediaQuery.of(context).size.width * 0.75;
    // double height = 50;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: ProductTextFieldWidget(),
              ),
              SizedBox(
                width: width / 20,
              ),
              // SizedBox.expand(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: ImageUpload(
                        height: 300,
                        width: width,
                        // height: 300,
                        // width: width * 25 * .75,
                      )),
                  submitButton(
                    context,
                    1.82,
                    5.65,
                  )
                ],
              ),
            ],
          ),
        ]);
  }
}
