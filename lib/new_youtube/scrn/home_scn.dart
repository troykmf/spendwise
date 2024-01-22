// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:spendwise/new_youtube/add_transactio.dart';
// import 'package:spendwise/new_youtube/database.dart';
// import 'package:spendwise/new_youtube/transaction_card.dart';
// import 'package:spendwise/src/tabs/transactions_card.dart';

// class HomeScn extends StatefulWidget {
//   const HomeScn({super.key});

//   @override
//   State<HomeScn> createState() => _HomeScnState();
// }

// class _HomeScnState extends State<HomeScn> {
//   _dialogBuilder(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return const AlertDialog(
//           content: AddTransactionForm(),
//         );
//       },
//     );
//   }

//   final db = Db();
//   final userId = FirebaseAuth.instance.currentUser!.uid;
//   @override
//   Widget build(BuildContext context) {
//     final userStream = db.getDoc(userId: userId);
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(FontAwesomeIcons.backward),
//             color: Colors.black,
//           )
//         ],
//         title: Text('Home Screen 2'),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _dialogBuilder(context);
//         },
//         child: Icon(
//           FontAwesomeIcons.cartShopping,
//           size: 15,
//         ),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//           stream: userStream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Text('Loading...');
//             } else if (snapshot.hasError) {
//               return const Text('An Error occured');
//             } else if (snapshot.hasData) {
//               var data = snapshot.data!.data() as Map<String, dynamic>;

//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     CardOne(
//                       data: data,
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     TransactionCard(),
//                     // BudgetedTab(),
//                   ],
//                 ),
//               );
//             } else {
//               return const Text('Could not find data');
//             }
//           }),
//     );
//   }
// }

// class CardOne extends StatelessWidget {
//   CardOne({super.key, required this.data});
//   final Map data;

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Container(
//           height: 100,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(10)),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'TOTAL BALANCE',
//                   style: TextStyle(fontSize: 10),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "${data['remainingAmount']}",
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       const SizedBox(height: 10.0),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               height: 100,
//               width: 150,
//               child: Stack(
//                 children: [
//                   const Positioned(
//                     right: 5,
//                     top: 5,
//                     child: CircleAvatar(
//                       backgroundColor: Color.fromARGB(255, 137, 186, 139),
//                       radius: 13,
//                       child: Icon(
//                         Icons.arrow_downward,
//                         color: Color.fromARGB(255, 74, 232, 80),
//                         size: 13,
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           'TOTAL BUDGET',
//                           style: TextStyle(fontSize: 10),
//                         ),
//                         const SizedBox(height: 10),
//                         // hereeeeeeeeeeeeeeeeeeeeeeee

//                         Text(
//                           "${data['totalCredit']}",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 20.0),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               height: 100,
//               width: 150,
//               child: Stack(
//                 children: [
//                   const Positioned(
//                     right: 5,
//                     top: 5,
//                     child: CircleAvatar(
//                       backgroundColor: Color.fromARGB(255, 214, 176, 173),
//                       radius: 13,
//                       child: Icon(
//                         Icons.arrow_upward,
//                         color: Colors.red,
//                         size: 13,
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           'TOTAL EXPENSE',
//                           style: TextStyle(fontSize: 10),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "${data['totalDebit']}",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ]);
//   }
// }
