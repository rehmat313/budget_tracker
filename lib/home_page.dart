
// import 'package:budget/statement_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'transaction_manager.dart';
// import 'income_expense_form.dart';
// import 'transaction_list.dart';
// import 'ad_mob_banner.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   String _searchQuery = '';
//
//   @override
//   Widget build(BuildContext context) {
//     final transactionManager = Provider.of<TransactionManager>(context);
//
//     if (!transactionManager.isBoxInitialized) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     final filteredTransactions = transactionManager.transactions.where((transaction) {
//       return transaction.description.toLowerCase().contains(_searchQuery.toLowerCase());
//     }).toList();
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Center(child: Text('Budget Tracker')),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     _searchQuery = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search transactions...',
//                   prefixIcon: const Icon(Icons.search),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: IncomeExpenseForm(
//                 descriptionController: _descriptionController,
//                 amountController: _amountController,
//                 addIncome: () {
//                   final description = _descriptionController.text;
//                   final amount = double.tryParse(_amountController.text);
//                   if (amount != null && description.isNotEmpty) {
//                     transactionManager.addTransaction(
//                       description: description,
//                       amount: amount,
//                       isIncome: true,
//                     );
//                     _descriptionController.clear();
//                     _amountController.clear();
//                   }
//                 },
//                 addExpense: () {
//                   final description = _descriptionController.text;
//                   final amount = double.tryParse(_amountController.text);
//                   if (amount != null && description.isNotEmpty) {
//                     transactionManager.addTransaction(
//                       description: description,
//                       amount: amount,
//                       isIncome: false,
//                     );
//                     _descriptionController.clear();
//                     _amountController.clear();
//                   }
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
//               child: Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Balance: \$${transactionManager.balance.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 3),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Income: \$${transactionManager.totalIncome.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),
//                           Text(
//                             'Expenses: \$${transactionManager.totalExpense.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 12.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TransactionList(
//                   transactions: filteredTransactions.map((transaction) {
//                     return {
//                       'description': transaction.description,
//                       'amount': transaction.amount,
//                       'isIncome': transaction.isIncome,
//                       'date': transaction.date,
//                     };
//                   }).toList(),
//                   deleteTransaction: (index) {
//                     final originalIndex = transactionManager.transactions.indexOf(filteredTransactions[index]);
//                     transactionManager.deleteTransaction(originalIndex);
//                   },
//                 ),
//               ),
//             ),
//             const AdMobBanner(
//               adSize: AdSize.banner,
//               adUnitId: 'ca-app-pub-9578159755783500/1024348229',
//             ),
//           ],
//         ),
//         floatingActionButton: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             FloatingActionButton.small(
//               onPressed: () async {
//                 // Show confirmation dialog before resetting transactions
//                 final shouldReset = await showDialog<bool>(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text('Confirm Reset'),
//                       content: const Text('Are you sure you want to reset all transactions? This action cannot be undone.'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(false); // User pressed "Cancel"
//                           },
//                           child: const Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(true); // User pressed "Confirm"
//                           },
//                           child: const Text('Confirm'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//
//                 // Proceed with reset if the user confirmed
//                 if (shouldReset == true) {
//                   transactionManager.resetTransactions();
//                 }
//               },
//               backgroundColor: Colors.redAccent,
//               tooltip: 'Reset All',
//               child: const Icon(Icons.refresh),
//             ),
//             const SizedBox(height: 10),
//             FloatingActionButton.small(
//               onPressed: () async {
//                 await StatementHandler().saveStatement(
//                   context,
//                   transactionManager.transactions,
//                   transactionManager.balance,
//                   transactionManager.totalIncome,
//                   transactionManager.totalExpense,
//                 );
//               },
//               backgroundColor: Colors.greenAccent,
//               tooltip: 'Save Statement',
//               child: const Icon(Icons.save),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:budget/statement_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_manager.dart';
import 'income_expense_form.dart';
import 'transaction_list.dart';
import 'ad_mob_banner.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final transactionManager = Provider.of<TransactionManager>(context);

    if (!transactionManager.isBoxInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final filteredTransactions = transactionManager.transactions.where((transaction) {
      return transaction.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Budget Tracker')),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search transactions...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IncomeExpenseForm(
                descriptionController: _descriptionController,
                amountController: _amountController,
                addIncome: () {
                  final description = _descriptionController.text;
                  final amount = double.tryParse(_amountController.text);
                  if (amount != null && description.isNotEmpty) {
                    transactionManager.addTransaction(
                      description: description,
                      amount: amount,
                      isIncome: true,
                    );
                    _descriptionController.clear();
                    _amountController.clear();
                  }
                },
                addExpense: () {
                  final description = _descriptionController.text;
                  final amount = double.tryParse(_amountController.text);
                  if (amount != null && description.isNotEmpty) {
                    transactionManager.addTransaction(
                      description: description,
                      amount: amount,
                      isIncome: false,
                    );
                    _descriptionController.clear();
                    _amountController.clear();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Balance: \$${transactionManager.balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Income: \$${transactionManager.totalIncome.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Expenses: \$${transactionManager.totalExpense.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TransactionList(
                  transactions: filteredTransactions.map((transaction) {
                    return {
                      'description': transaction.description,
                      'amount': transaction.amount,
                      'isIncome': transaction.isIncome,
                      'date': transaction.date,
                    };
                  }).toList(),
                  deleteTransaction: (index) {
                    final originalIndex = transactionManager.transactions.indexOf(filteredTransactions[index]);
                    transactionManager.deleteTransaction(originalIndex);
                  },
                ),
              ),
            ),
            const AdMobBanner(
              adSize: AdSize.banner,
              adUnitId: 'ca-app-pub-3940256099942544/9214589741',
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.small(
              onPressed: () async {
                final shouldReset = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Reset'),
                      content: const Text(
                        'Are you sure you want to reset all transactions? This action cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );

                // if (shouldReset == true) {
                //   transactionManager.resetTransactions();
                //   setState(() {
                //     _searchQuery = ''; // Reset the search query
                //   });
                // }
                if (shouldReset == true) {
                  transactionManager.resetTransactions();
                  Future.delayed(const Duration(milliseconds: 100), () {
                    setState(() {
                      _searchQuery = ''; // Reset the search query
                    });
                  });
                }
              },
              backgroundColor: Colors.redAccent,
              tooltip: 'Reset All',
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(height: 10),
            FloatingActionButton.small(
              onPressed: () async {
                await StatementHandler().saveStatement(
                  context,
                  transactionManager.transactions,
                  transactionManager.balance,
                  transactionManager.totalIncome,
                  transactionManager.totalExpense,
                );
              },
              backgroundColor: Colors.greenAccent,
              tooltip: 'Save Statement',
              child: const Icon(Icons.save),
            ),
          ],
        ),
      ),
    );
  }
}
