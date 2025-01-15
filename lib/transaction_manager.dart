
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'transaction_model.dart';
//
// class TransactionManager extends ChangeNotifier {
//   late Box<Transaction> _transactionBox;
//   bool _isBoxInitialized = false; // Tracks whether the box is initialized
//
//   TransactionManager() {
//     _initializeBox();
//   }
//
//   Future<void> _initializeBox() async {
//     _transactionBox = await Hive.openBox<Transaction>('transactions');
//     _isBoxInitialized = true; // Set to true after initialization
//     notifyListeners(); // Notify listeners of the change
//   }
//
//   bool get isBoxInitialized => _isBoxInitialized;
//
//   List<Transaction> get transactions {
//     if (!_isBoxInitialized) {
//       return []; // Return an empty list if the box is not initialized
//     }
//     return _transactionBox.values.toList();
//   }
//
//   double get balance {
//     if (!_isBoxInitialized) {
//       return 0.0; // Return 0.0 if the box is not initialized
//     }
//     double total = 0.0;
//     for (var transaction in _transactionBox.values) {
//       total += transaction.isIncome ? transaction.amount : -transaction.amount;
//     }
//     return total;
//   }
//
//   double get totalIncome {
//     if (!_isBoxInitialized) {
//       return 0.0;
//     }
//     return _transactionBox.values
//         .where((transaction) => transaction.isIncome)
//         .fold(0.0, (sum, transaction) => sum + transaction.amount);
//   }
//
//   double get totalExpense {
//     if (!_isBoxInitialized) {
//       return 0.0;
//     }
//     return _transactionBox.values
//         .where((transaction) => !transaction.isIncome)
//         .fold(0.0, (sum, transaction) => sum + transaction.amount);
//   }
//
//   void addTransaction({
//     required String description,
//     required double amount,
//     required bool isIncome,
//   }) {
//     if (!_isBoxInitialized) return;
//
//     final transaction = Transaction(
//       description: description,
//       amount: amount,
//       isIncome: isIncome,
//       date: DateTime.now(),
//     );
//
//     _transactionBox.add(transaction);
//     notifyListeners();
//   }
//
//   void deleteTransaction(int index) {
//     if (!_isBoxInitialized) return;
//
//     _transactionBox.deleteAt(index);
//     notifyListeners();
//   }
//
//   void resetTransactions() {
//     if (!_isBoxInitialized) return;
//
//     _transactionBox.clear();
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'transaction_model.dart';

class TransactionManager extends ChangeNotifier {
  late Box<Transaction> _transactionBox;
  bool _isBoxInitialized = false;

  TransactionManager() {
    _initializeBox();
  }

  Future<void> _initializeBox() async {
    _transactionBox = await Hive.openBox<Transaction>('transactions');
    _isBoxInitialized = true;
    notifyListeners();
  }

  bool get isBoxInitialized => _isBoxInitialized;

  List<Transaction> get transactions {
    if (!_isBoxInitialized) {
      return [];
    }
    return _transactionBox.values.toList();
  }

  double get balance {
    if (!_isBoxInitialized) {
      return 0.0;
    }
    return _transactionBox.values.fold(0.0, (sum, transaction) {
      return sum + (transaction.isIncome ? transaction.amount : -transaction.amount);
    });
  }

  double get totalIncome {
    if (!_isBoxInitialized) {
      return 0.0;
    }
    return _transactionBox.values
        .where((transaction) => transaction.isIncome)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double get totalExpense {
    if (!_isBoxInitialized) {
      return 0.0;
    }
    return _transactionBox.values
        .where((transaction) => !transaction.isIncome)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  void addTransaction({
    required String description,
    required double amount,
    required bool isIncome,
  }) {
    if (!_isBoxInitialized) return;

    final transaction = Transaction(
      description: description,
      amount: amount,
      isIncome: isIncome,
      date: DateTime.now(),
    );

    _transactionBox.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(int index) {
    if (!_isBoxInitialized) return;

    _transactionBox.deleteAt(index);
    notifyListeners();
  }

  void resetTransactions() {
    if (!_isBoxInitialized) return;

    print("Resetting transactions...");
    _transactionBox.clear();
    notifyListeners();
    print("All transactions cleared.");
  }
}
