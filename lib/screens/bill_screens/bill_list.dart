import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/bill_model.dart';
import 'package:flutter_expense_tracker/services/bill_services.dart';
import 'package:flutter_expense_tracker/widgets/bill_card.dart'; 


class BillListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bills',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 142, 62, 156))),
                centerTitle: true,
      ),
      body: StreamBuilder<List<Bill>>(
        stream: BillService().getBills(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bills found.'));
          }
          final bills = snapshot.data!;
          return Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ListView.builder(
              itemCount: bills.length,
              itemBuilder: (context, index) {
                return BillCard(bill: bills[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
