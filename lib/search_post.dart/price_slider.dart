// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gigbooker/cubit/reg_button_cubit.dart';

// class VenuePriceRangeSlider extends StatefulWidget {
//   final double venuePriceMin;
//   final double venuePriceMax;

//   const VenuePriceRangeSlider({
//     Key? key,
//     required this.venuePriceMin,
//     required this.venuePriceMax,
//   }) : super(key: key);

//   @override
//   State<VenuePriceRangeSlider> createState() => _VenuePriceRangeSliderState();
// }

// class _VenuePriceRangeSliderState extends State<VenuePriceRangeSlider> {
//   final firestore = FirebaseFirestore.instance;
//   final user = FirebaseAuth.instance.currentUser!.uid;
//   double _lowerValue = 0.0;
//   double _upperValue = 1000.0;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegButtonCubit, RegButtonState>(
//       builder: (context, state) {
//         return RangeSlider(
//           activeColor: Colors.blue,
//           inactiveColor: Colors.white,
//           values: RangeValues(_lowerValue, _upperValue),
//           min: 0,
//           max: 1000,
//           divisions: 100,
//           labels: RangeLabels(
//             '${_lowerValue.round()}',
//             '${_upperValue.round()}',
//           ),
//           onChanged: (RangeValues rangeValues) {
//             setState(() {
//               _lowerValue = rangeValues.start;
//               _upperValue = rangeValues.end;
//               context.read<RegButtonCubit>().venuePriceRangeSliderCounter(
//                   venuePriceRangeSliderCounter:
//                       RangeValues(_lowerValue, _upperValue));
//               firestore.collection('venues').doc(user).update({
//                 'venue_price_min': _lowerValue,
//                 'venue_price_max': _upperValue
//               });
//             });
//           },
//         );
//       },
//     );
//   }
// }