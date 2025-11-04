import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant;
      case 'Transport':
        return Icons.directions_car;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Entertainment':
        return Icons.movie;
      case 'Bills':
        return Icons.receipt;
      case 'Healthcare':
        return Icons.medical_services;
      case 'Education':
        return Icons.school;
      default:
        return Icons.category;
    }
  }

  Color _getAmountColor(bool isIncome) {
    return Colors.white; // Always white for visibility
  }

  Color _getTextColor(bool isIncome) {
    return Colors.white; // Make ALL text white for visibility
  }

  Color _getSubtitleColor(bool isIncome) {
    return Colors.grey[400]!; // Lighter grey for subtitles
  }

  Color _getIconColor(bool isIncome) {
    return Colors.white; // Make ALL icons white
  }

  String _getAmountPrefix(bool isIncome) {
    return isIncome ? '+' : '-';
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.key.toString()),
      background: Container(
        color: Colors.grey[800],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.grey[500]),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Delete Transaction?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text(
                            "DELETE",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<TransactionProvider>(context, listen: false)
            .deleteTransaction(transaction);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Transaction deleted'),
            backgroundColor: Colors.grey[800],
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[800]!, width: 0.5),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[700]!,
                  width: 1,
                ),
              ),
              child: Icon(
                _getCategoryIcon(transaction.category),
                color: _getIconColor(transaction.isIncome),
                size: 18,
              ),
            ),
            title: Text(
              transaction.title.toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _getTextColor(transaction.isIncome), // White text
                letterSpacing: 0.5,
              ),
            ),
            subtitle: Text(
              '${transaction.category} • ${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
              style: TextStyle(
                fontSize: 11,
                color: _getSubtitleColor(transaction.isIncome), // Lighter grey
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: Text(
              '${_getAmountPrefix(transaction.isIncome)}₹${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _getAmountColor(transaction.isIncome), // White text
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}