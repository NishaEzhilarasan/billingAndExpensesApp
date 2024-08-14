import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/services/report_services.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define your date range here. For example, last 7 days:
    DateTime startDate = DateTime.now().subtract(Duration(days: 7));
    DateTime endDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 142, 62, 156),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ReportService().generateReport(startDate, endDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No report data available.'));
          }

          final reportData = snapshot.data as Map<String, dynamic>;
          final totalPersonal = reportData['totalPersonal'];
          final totalBusiness = reportData['totalBusiness'];

          return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: [
              _buildReportCard(
                title: 'Total Personal Expenses',
                subtitle: 'Amount: \$${totalPersonal.toStringAsFixed(2)}',
                icon: Icons.person,
                color: Colors.blueAccent,
              ),
              SizedBox(height: 16.0),
              _buildReportCard(
                title: 'Total Business Expenses',
                subtitle: 'Amount: \$${totalBusiness.toStringAsFixed(2)}',
                icon: Icons.business,
                color: Colors.greenAccent,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReportCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
