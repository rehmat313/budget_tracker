// import 'package:flutter/material.dart';
//
// class IncomeExpenseForm extends StatelessWidget {
//   final TextEditingController descriptionController;
//   final TextEditingController amountController;
//   final VoidCallback addIncome;
//   final VoidCallback addExpense;
//
//   const IncomeExpenseForm({super.key,
//     required this.descriptionController,
//     required this.amountController,
//     required this.addIncome,
//     required this.addExpense,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: descriptionController,
//           decoration: const InputDecoration(labelText: 'Description'),
//         ),
//         TextField(
//           controller: amountController,
//           decoration: const InputDecoration(labelText: 'Amount'),
//           keyboardType: TextInputType.number,
//         ),
//         const SizedBox(height: 10,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ElevatedButton(
//               onPressed: addIncome,
//               child: const Text('Add Income'),
//             ),
//             ElevatedButton(
//               onPressed: addExpense,
//               child: const Text('Add Expense'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class IncomeExpenseForm extends StatelessWidget {
  final TextEditingController descriptionController;
  final TextEditingController amountController;
  final VoidCallback addIncome;
  final VoidCallback addExpense;

  const IncomeExpenseForm({
    super.key,
    required this.descriptionController,
    required this.amountController,
    required this.addIncome,
    required this.addExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[100], // Light green for income
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: addIncome,
              child: const Text('Add Income'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[100], // Light red for expense
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: addExpense,
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ],
    );
  }
}
