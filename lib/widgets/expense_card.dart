import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense_model.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  ExpenseCard({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: ListTile(
          title: Text(
           capitalizeFirst( expense.description),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${expense.category} - ${DateFormat('yyyy-MM-dd').format(expense.date)}',
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: Text(
            '\$${expense.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 142, 62, 156)
            ),
          ),
        ),
      ),
    );
  }
  String capitalizeFirst(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

}
