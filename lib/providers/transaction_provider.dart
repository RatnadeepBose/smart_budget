import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  late Box<TransactionModel> _transactionsBox;
  bool _isInitialized = false;

  TransactionProvider() {
    _init();
  }

  Future<void> _init() async {
    _transactionsBox = Hive.box<TransactionModel>('transactions');
    _isInitialized = true;
    notifyListeners();
  }

  List<TransactionModel> get transactions {
    if (!_isInitialized) return [];
    return _transactionsBox.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<TransactionModel> get expenses {
    return transactions.where((transaction) => !transaction.isIncome).toList();
  }

  List<TransactionModel> get incomes {
    return transactions.where((transaction) => transaction.isIncome).toList();
  }

  double get totalIncome {
    return incomes.fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double get totalExpenses {
    return expenses.fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double get balance {
    return totalIncome - totalExpenses;
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionsBox.add(transaction);
    notifyListeners();
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    await transaction.delete();
    notifyListeners();
  }

  Future<void> deleteTransactionByKey(String key) async {
    await _transactionsBox.delete(key);
    notifyListeners();
  }

  Map<String, double> getCategoryExpenses() {
    Map<String, double> categoryMap = {};
    for (var transaction in expenses) {
      categoryMap.update(
        transaction.category,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }
    return categoryMap;
  }
}