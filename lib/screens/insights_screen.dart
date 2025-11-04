import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'SPENDING INSIGHTS',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          final categoryExpenses = transactionProvider.getCategoryExpenses();

          if (categoryExpenses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pie_chart, size: 64, color: Colors.grey[700]),
                  const SizedBox(height: 16),
                  Text(
                    'No expense data yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Pie Chart
                SizedBox(
                  height: 300,
                  child: PieChart(
                    PieChartData(
                      sections: _buildChartSections(categoryExpenses),
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Legend
                ..._buildLegend(categoryExpenses, context),
              ],
            ),
          );
        },
      ),
    );
  }

  List<PieChartSectionData> _buildChartSections(Map<String, double> categoryExpenses) {
    final total = categoryExpenses.values.fold(0.0, (sum, amount) => sum + amount);
    final colors = [
      Colors.white,
      Colors.grey[400]!,
      Colors.grey[600]!,
      Colors.grey[800]!,
      Colors.grey[300]!,
      Colors.grey[500]!,
      Colors.grey[700]!,
      Colors.grey[900]!,
    ];

    return categoryExpenses.entries.map((entry) {
      final index = categoryExpenses.keys.toList().indexOf(entry.key);
      final percentage = (entry.value / total * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: colors[index % colors.length],
        value: entry.value,
        title: '$percentage%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  List<Widget> _buildLegend(Map<String, double> categoryExpenses, BuildContext context) {
    final colors = [
      Colors.white,
      Colors.grey[400]!,
      Colors.grey[600]!,
      Colors.grey[800]!,
      Colors.grey[300]!,
      Colors.grey[500]!,
      Colors.grey[700]!,
      Colors.grey[900]!,
    ];

    return categoryExpenses.entries.map((entry) {
      final index = categoryExpenses.keys.toList().indexOf(entry.key);

      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[800]!, width: 0.5),
          ),
        ),
        child: ListTile(
          leading: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: colors[index % colors.length],
              shape: BoxShape.circle,
            ),
          ),
          title: Text(
            entry.key.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
          ),
          trailing: Text(
            '₹${entry.value.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }).toList();
  }
}