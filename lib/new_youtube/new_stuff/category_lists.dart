// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:spendwise/new_youtube/app_icons.dart';
//
// class CatgeoryLists extends StatefulWidget {
//   const CatgeoryLists({super.key, required this.onchanged});
//   final ValueChanged<String?> onchanged;
//
//   @override
//   State<CatgeoryLists> createState() => _CatgeoryListsState();
// }
//
// class _CatgeoryListsState extends State<CatgeoryLists> {
//   String currentCategory = '';
//   List<Map<String, dynamic>> categoryList = [];
//   final scrollController = ScrollController();
//   var appIcons = Appicons();
//   var addCart = {
//     'name': 'All',
//     'icon': FontAwesomeIcons.cartPlus,
//   };
//
//   @override
//   void initState() {
//     setState(() {
//       categoryList = appIcons.homeExpensesCategories;
//       categoryList.insert(0, addCart);
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         itemCount: categoryList.length,
//         controller: scrollController,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           var data = appIcons.homeExpensesCategories[index];
//           return GestureDetector(
//             onTap: () {},
//             child: Container(
//               margin: const EdgeInsets.all(8),
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               decoration: BoxDecoration(
//                 color: currentCategory == data['name']
//                     ? Colors.blue[900]
//                     : Colors.blue.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Center(
//                 child: Row(
//                   children: [
//                     Icon(
//                       data['icon'],
//                       size: 10,
//                       color: currentCategory == data['name']
//                           ? Colors.white
//                           : Colors.blue[900],
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       data['name'],
//                       style: TextStyle(
//                         color: currentCategory == data['name']
//                             ? Colors.white
//                             : Colors.blue[900],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
