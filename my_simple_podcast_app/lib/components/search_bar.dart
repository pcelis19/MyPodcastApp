// import 'package:flutter/material.dart';

// class SearchBar extends StatefulWidget with PreferredSizeWidget {
//   SearchBar({Key key}) : super(key: key);

//   @override
//   _SearchBarState createState() => _SearchBarState();

//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize {
//     return Size.fromHeight(100);
//   }
// }

// class _SearchBarState extends State<SearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     ThemeData _themeData = Theme.of(context);
//     return Container(
//       color: _themeData.primaryColor,
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: IconButton(
//                 color: _themeData.primaryIconTheme.color,
//                 icon: Icon(Icons.menu),
//                 onPressed: () {
//                   // TODO implement function
//                 }),
//           ),
//           Expanded(
//             flex: 7,
//             child: Card(
//               elevation: 18,
//               child: ListTile(
//                 title: TextFormField(),
//                 trailing: IconButton(
//                     icon: Icon(Icons.search),
//                     onPressed: () {
//                       // TODO implement function
//                     }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
