import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final bool isIncome;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.isIncome,
  });

  @override
  String toString() {
    return 'TransactionModel(title: $title, amount: $amount, category: $category, date: $date, isIncome: $isIncome)';
  }
}