import 'package:flutter/material.dart';

Widget buildStatusChip(String status) {
  Color backgroundColor;
  Color textColor;

  switch (status.toLowerCase()) {
    case 'shipping':
      backgroundColor = Colors.green.shade50;
      textColor = Colors.green.shade700;
      break;
    case 'pending':
      backgroundColor = Colors.orange.shade50;
      textColor = Colors.orange.shade700;
      break;
    case 'cancelled':
      backgroundColor = Colors.red.shade50;
      textColor = Colors.red.shade700;
      break;
    case 'delivered':
      backgroundColor = Colors.teal.shade50;
      textColor = Colors.teal.shade700;
      break;
    default:
      backgroundColor = Colors.blue.shade50;
      textColor = Colors.blue.shade700;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      status,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    ),
  );
}
