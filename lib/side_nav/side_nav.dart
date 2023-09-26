// import 'package:flutter/material.dart';

// class SideDrawer extends StatelessWidget {
//   const SideDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Side Navigation Bar',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home'),
//             onTap: () {
//               // Navigate to the home page or perform desired actions
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () {
//               // Navigate to the settings page or perform desired actions
//               Navigator.pop(context);
//             },
//           ),
//           // Add more ListTiles for additional menu items
//         ],
//       ),
//     );
//   }
// }
