import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/summary_card.dart';
import '../widgets/transaction_tile.dart';
import 'add_transaction_screen.dart';
import 'insights_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SMARTBUDGET',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 2.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.insights, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InsightsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          // ... in HomeScreen build method ...

// Summary Cards
          Consumer<TransactionProvider>(
            builder: (context, transactionProvider, child) {
              return Padding(
                padding: const EdgeInsets.all(12.0), // Reduced padding
                child: Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        title: 'INCOME',
                        amount: transactionProvider.totalIncome,
                        color: Colors.grey[400]!,
                        icon: Icons.arrow_upward,
                      ),
                    ),
                    const SizedBox(width: 6), // Reduced spacing
                    Expanded(
                      child: SummaryCard(
                        title: 'EXPENSE',
                        amount: transactionProvider.totalExpenses,
                        color: Colors.white,
                        icon: Icons.arrow_downward,
                      ),
                    ),
                    const SizedBox(width: 6), // Reduced spacing
                    Expanded(
                      child: SummaryCard(
                        title: 'BALANCE',
                        amount: transactionProvider.balance,
                        color: transactionProvider.balance >= 0
                            ? Colors.grey[400]!
                            : Colors.white,
                        icon: Icons.account_balance_wallet,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

// ... rest of the code ...

          // Transactions List
          Expanded(
            child: Consumer<TransactionProvider>(
              builder: (context, transactionProvider, child) {
                final transactions = transactionProvider.transactions;

                if (transactions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long, size: 64, color: Colors.grey[700]),
                        const SizedBox(height: 16),
                        Text(
                          'No transactions yet',
                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        Text(
                          'Tap + to add your first transaction',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return TransactionTile(transaction: transaction);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}