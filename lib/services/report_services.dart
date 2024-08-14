import 'package:cloud_firestore/cloud_firestore.dart';

class ReportService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> generateReport(DateTime start, DateTime end) async {
    QuerySnapshot expensesSnapshot = await _db.collection('expenses')
      .where('date', isGreaterThanOrEqualTo: start)
      .where('date', isLessThanOrEqualTo: end)
      .get();

    double totalPersonal = 0;
    double totalBusiness = 0;

    for (var doc in expensesSnapshot.docs) {
      if (doc['isBusiness']) {
        totalBusiness += doc['amount'];
      } else {
        totalPersonal += doc['amount'];
      }
    }

    return {
      'totalPersonal': totalPersonal,
      'totalBusiness': totalBusiness,
    };
  }
}
