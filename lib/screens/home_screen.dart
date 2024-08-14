import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter_expense_tracker/models/bill_model.dart';
import 'package:flutter_expense_tracker/screens/local_notification_screens/due_bill.dart';
import 'package:flutter_expense_tracker/services/auth_services.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedCardIndex;
  List<Bill> _dueBills = []; // Store due bills

  @override
  void initState() {
    super.initState();
    _checkDueBills();
  }

  Future<void> _checkDueBills() async {
    List<Bill> allBills = await _fetchAllBills(); // Fetch bills from Firestore

    DateTime now = DateTime.now();
    _dueBills = allBills.where((bill) => !bill.isPaid && bill.dueDate.isBefore(now)).toList();

    for (Bill bill in _dueBills) {
      await NotificationService().scheduleNotification(
        bill.id.hashCode, // Ensure unique ID for each notification
        'Bill Due: ${bill.name}',
        'Amount: \$${bill.amount}',
        bill.dueDate,
      );
    }

    setState(() {}); // Update UI to show due bills
  }

  Future<List<Bill>> _fetchAllBills() async {
    // Fetch bills from Firestore
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bills').get();

    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Bill(
        id: doc.id,
        name: data['name'],
        amount: data['amount'].toDouble(),
        dueDate: (data['dueDate'] as Timestamp).toDate(),
        isPaid: data['isPaid'],
      );
    }).toList();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker & Billing',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 142, 62, 156)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              AuthService().signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCardIndex = index;
                    });

                    switch (index) {
                      case 0:
                        Navigator.pushNamed(context, '/add-expense');
                        break;
                      case 1:
                        Navigator.pushNamed(context, '/expense-list');
                        break;
                      case 2:
                        Navigator.pushNamed(context, '/add-bill');
                        break;
                      case 3:
                        Navigator.pushNamed(context, '/bill-list');
                        break;
                      case 4:
                        Navigator.pushNamed(context, '/report');
                        break;
                    }
                  },
                  child: Card(
                    elevation: 4.0,
                    color: _selectedCardIndex == index
                        ? Color.fromARGB(255, 142, 62, 156)
                        : Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 32,
                      height: 120,
                      alignment: Alignment.center,
                      child: Text(
                        _getTitle(index),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedCardIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            if (_dueBills.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16.0),
                color: Color.fromARGB(255, 142, 62, 156),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Due Bills',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    ..._dueBills.map((bill) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: ListTile(
                          title: Text(capitalizeFirst(bill.name)),
                          subtitle: Text('Amount: \$${bill.amount}'),
                          trailing: Text( DateFormat('yyyy-MM-dd').format(bill.dueDate),style: TextStyle(color:Colors.red),),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
String capitalizeFirst(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Add Expense';
      case 1:
        return 'View Expenses';
      case 2:
        return 'Add Bill';
      case 3:
        return 'View Bills';
      case 4:
        return 'Generate Report';
      default:
        return '';
    }
  }
}
