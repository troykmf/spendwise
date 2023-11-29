import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BudgetTile extends StatelessWidget {
  const BudgetTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  final String name;
  final String amount;
  final DateTime dateTime;
  final Function(BuildContext)? deleteTapped;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(4),
          )
        ],
      ),
      child: ListTile(
        title: Text(name),
        trailing: Text(
          '#$amount',
          style: const TextStyle(color: Colors.green),
        ),
        subtitle: Text(
          '${dateTime.day}/${dateTime.month}/${dateTime.year}',
        ),
      ),
    );
  }
}
