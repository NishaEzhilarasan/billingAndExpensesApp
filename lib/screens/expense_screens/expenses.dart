import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense_model.dart';
import 'package:flutter_expense_tracker/services/expense_services.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedCategory = 'Food';
  bool _isBusiness = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 142, 62, 156))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _descriptionController,
                labelText: 'Description',
                hintText: 'Enter description',
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _amountController,
                labelText: 'Amount',
                hintText: 'Enter amount',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              _buildDropdown(),
              SizedBox(height: 16.0),
              _buildCheckbox(),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  backgroundColor: Color.fromARGB(255, 142, 62, 156),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                ),
                onPressed: () {
                  final expense = Expense(
                    id: '',
                    description: _descriptionController.text,
                    amount: double.parse(_amountController.text),
                    category: _selectedCategory,
                    date: DateTime.now(),
                    isBusiness: _isBusiness,
                  );
                  ExpenseService().addExpense(expense);
                  Navigator.pop(context);
                },
                child: Text(
                  'Add Expense',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color:
                Color.fromARGB(255, 93, 23, 122), // Border color when focused
            width: 2.0, // Border width when focused
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color:
                Color.fromARGB(255, 93, 23, 122), // Border color when focused
            width: 2.0, // Border width when focused
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      items: <String>['Food', 'Travel', 'Entertainment'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue!;
        });
      },
      
    );
  }

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isBusiness,
          onChanged: (newValue) {
            setState(() {
              _isBusiness = newValue!;
            });
          },
          activeColor: Color.fromARGB(255, 142, 62, 156), // Color when checked
          checkColor: Colors.white, // Color of the checkmark
        ),
        Expanded(
          child: Text(
            'Is this a business expense?',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
