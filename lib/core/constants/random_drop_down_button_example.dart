// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class RandomDropDownButtonExample extends StatelessWidget {
//   const RandomDropDownButtonExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('currency').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           const Text('Loading');
//         } else {
//           List<DropdownMenuItem> currencyItems = [];
          
//           for (int i = 0; i < snapshot.data.docs.length; i++) {
//             DocumentSnapshot snapshot = snapshot.get(DocumentSnapshot)[i];
//             currencyItems
//                 .add(DropdownMenuItem(child: Text(snapshot.documnentID)));
//           }
//         }
//       },
//     );
//   }
// }
