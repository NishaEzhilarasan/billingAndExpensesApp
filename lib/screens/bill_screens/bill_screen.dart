import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/bill_model.dart';
import 'package:flutter_expense_tracker/services/bill_services.dart';
import 'package:intl/intl.dart';

class AddBillScreen extends StatefulWidget {
  @override
  _AddBillScreenState createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  DateTime _selectedDueDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _dueDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDueDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bill',
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
                controller: _nameController,
                labelText: 'Bill Name',
                hintText: 'Enter bill name',
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _amountController,
                labelText: 'Amount',
                hintText: 'Enter amount',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              _buildDatePicker(),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color.fromARGB(255, 142, 62, 156),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                ),
                onPressed: () {
                  final bill = Bill(
                    id: '',
                    name: _nameController.text,
                    amount: double.parse(_amountController.text),
                    dueDate: _selectedDueDate,
                    isPaid: false,
                  );
                  BillService().addBill(bill);
                  Navigator.pop(context);
                },
                child: Text(
                  'Add Bill',
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

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDueDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2101),
        );
        if (picked != null && picked != _selectedDueDate) {
          setState(() {
            _selectedDueDate = picked;
            _dueDateController.text =
                DateFormat('yyyy-MM-dd').format(_selectedDueDate);
          });
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: _dueDateController,
          decoration: InputDecoration(
            labelText: 'Due Date',
            hintText: DateFormat('yyyy-MM-dd').format(_selectedDueDate),
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ),
    );
  }
}
