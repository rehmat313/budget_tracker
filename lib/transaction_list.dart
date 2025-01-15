import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  // final Function(int) editTransaction;
  final Function(int) deleteTransaction;

  const TransactionList({super.key, 
    required this.transactions,
    // required this.editTransaction,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction['description']),
          subtitle: Text(
            '\$${transaction['amount'].toStringAsFixed(2)} - ${transaction['date'].toString().split(' ')[0]}',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                transaction['isIncome'] ? Icons.arrow_upward : Icons.arrow_downward,
                color: transaction['isIncome'] ? Colors.green : Colors.red,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteTransaction(index), // Pass index to deleteTransaction
              ),
            ],
          ),
        );
      },
    );
  }
}
