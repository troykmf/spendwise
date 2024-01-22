import 'package:flutter/material.dart';
import 'package:spendwise/new_youtube/app_icons.dart';

class CategoryDropdown extends StatelessWidget {
  CategoryDropdown({super.key, this.cattype, required this.onchanged});
  final String? cattype;
  final ValueChanged<String?> onchanged;
  final appIcons = Appicons();
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: const Text('select category'),
      items: appIcons.homeExpensesCategories
          .map(
            (e) => DropdownMenuItem<String>(
              value: e['name'],
              child: Row(
                children: [
                  Icon(e['icon']),
                  const SizedBox(width: 12),
                  Text(e['name']),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: onchanged,
    );

    //     DropdownButton<String>(
    //   isExpanded: true,
    //   hint: const Text('Select Category'),
    //   value: cattype,
    //   items: appIcons.homeExpensesCategories
    //       .map((e) => DropdownMenuItem<String>(
    //           value: e['name'],
    //           child: Row(
    //             children: [
    //               Icon(
    //                 e['icon'],
    //                 color: Colors.black54,
    //               ),
    //               const SizedBox(width: 10),
    //               Text(
    //                 e['name'],
    //                 style: const TextStyle(color: Colors.black45),
    //               ),
    //             ],
    //           )))
    //       .toList(),
    //   onChanged: onchanged,
    // );
  }
}
