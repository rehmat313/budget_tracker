
import 'package:flutter/material.dart';
import 'transaction_model.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class StatementHandler {
  Future<void> saveStatement(
      BuildContext context,
      List<Transaction> transactions,
      double balance,
      double totalIncome,
      double totalExpense) async {
    String statement = 'Balance: Rs.${balance.toStringAsFixed(0)}\n';
    statement += 'Total Income: Rs.${totalIncome.toStringAsFixed(0)}\n';
    statement += 'Total Expense: Rs.${totalExpense.toStringAsFixed(0)}\n\n';
    statement += 'Transactions:\n';

    for (var transaction in transactions) {
      statement +=
      '${transaction.date.toString().split(' ')[0]} - ${transaction.description}: Rs.${transaction.amount} (${transaction.isIncome ? 'Income' : 'Expense'})\n';
    }

    try {
      // Request permission to write to external storage
      if (await Permission.storage.request().isGranted) {
        // Access the "Downloads" directory
        Directory downloadsDir = Directory('/storage/emulated/0/Download');
        if (!downloadsDir.existsSync()) {
          throw Exception('Downloads directory does not exist.');
        }

        // Create the file path
        final fileName =
            'transaction_statement_${DateTime.now().toIso8601String().split("T").first}.txt';
        final filePath = '${downloadsDir.path}/$fileName';

        // Write the statement to the file
        final file = File(filePath);
        await file.writeAsString(statement);

        // Show success dialog
        _showSuccessDialog(context, filePath);
      } else {
        throw Exception('Storage permission denied.');
      }
    } catch (e) {
      // Show error dialog
      _showErrorDialog(context, e);
    }
  }

  void _showSuccessDialog(BuildContext context, String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Statement Saved'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Prevents unbounded height errors
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Transaction statement saved to:'),
              Text(filePath),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, dynamic error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to save the statement: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
