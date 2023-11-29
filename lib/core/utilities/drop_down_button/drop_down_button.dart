import 'package:flutter/material.dart';
import 'package:spendwise/services/auth/auth_service.dart';

enum TransactionType { budget, expense }

class TransactionTypeDDB extends StatefulWidget {
  const TransactionTypeDDB({super.key});

  @override
  State<TransactionTypeDDB> createState() => _TransactionTypeDDBState();
}

class _TransactionTypeDDBState extends State<TransactionTypeDDB> {
  String get userId => AuthService.firebase().currentUser!.id;
  var currentValue = TransactionType.budget;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TransactionType>(
      isExpanded: true,
      items: TransactionType.values
          .map(
            (transType) => DropdownMenuItem<TransactionType>(
              value: transType,
              child: Text(
                transType.toString().split('.').last,
              ),
            ),
          )
          .toList(),
      onChanged: (newValue) {
        setState(
          () {
            currentValue = newValue!;
            print(currentValue);
          },
        );
      },
      value: currentValue,
      hint: const Text('Choose Transaction Type'),
    );
  }
}

// class TransacitionType extends StatefulWidget {
//   const TransacitionType({super.key});

//   @override
//   State<TransacitionType> createState() => _TransacitionTypeState();
// }

// class _TransacitionTypeState extends State<TransacitionType> {
//   String selectedItem = 'budget';

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//       items: <String>['budget', 'expense'].map((String value) {
//         return DropdownMenuItem(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       value: selectedItem,
//       onChanged: (String? newValue) {
//         setState(
//           () {
//             selectedItem = newValue!;
//           },
//         );
//       },
//     );
//   }
// }
