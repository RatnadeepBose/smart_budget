import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[800]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and title in a row with flexible space
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 14), // Smaller icon
                const SizedBox(width: 4), // Reduced spacing
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 10, // Smaller font
                      color: color.withOpacity(0.8),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.8, // Reduced letter spacing
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6), // Reduced spacing
            Text(
              '₹${amount.toStringAsFixed(0)}', // Remove decimals to save space
              style: TextStyle(
                fontSize: 14, // Slightly smaller
                fontWeight: FontWeight.w400,
                color: color,
                letterSpacing: 0.3, // Reduced letter spacing
              ),
            ),
          ],
        ),
      ),
    );
  }
}