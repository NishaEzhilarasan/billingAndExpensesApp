import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_expense_tracker/screens/login_screens/auth_wrapper.dart';
import 'package:flutter_expense_tracker/screens/bill_screens/bill_list.dart';
import 'package:flutter_expense_tracker/screens/bill_screens/bill_screen.dart';
import 'package:flutter_expense_tracker/screens/expense_screens/expenses.dart';
import 'package:flutter_expense_tracker/screens/expense_screens/expenses_list.dart';
import 'package:flutter_expense_tracker/screens/home_screen.dart';
import 'package:flutter_expense_tracker/screens/login_screens/login_screen.dart';
import 'package:flutter_expense_tracker/screens/report_screens/report_screen.dart';
import 'package:flutter_expense_tracker/screens/login_screens/sign_in_screen.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
     tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/add-expense': (context) => AddExpenseScreen(),
        '/add-bill': (context) => AddBillScreen(),
        '/expense-list': (context) => ExpenseListScreen(),
        '/bill-list': (context) => BillListScreen(),
        '/report': (context) => ReportScreen(),
      },
    );
  }
}
