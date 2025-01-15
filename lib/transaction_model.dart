import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final bool isIncome;

  @HiveField(3)
  final DateTime date;

  Transaction({
    required this.description,
    required this.amount,
    required this.isIncome,
    required this.date,
  });
}
