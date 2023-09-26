// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // Step 1: Create a ScrollController
//   final ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scroll to Position Example'),
//       ),
//       body: Column(
//         children: [
//           // Step 2: Attach the ScrollController to a ListView
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: 100,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text('Item $index'),
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Step 3: Use animateTo to scroll to a specific position
//               _scrollController.animateTo(
//                 400.0,  // 400 pixels down
//                 curve: Curves.easeOut,
//                 duration: const Duration(milliseconds: 300),
//               );
//             },
//             child: Text('Scroll Down'),
//           ),
//         ],
//       ),
//     );
//   }
// }
