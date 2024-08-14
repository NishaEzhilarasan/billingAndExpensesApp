import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_expense_tracker/models/bill_model.dart';


class BillService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addBill(Bill bill) {
    return _db.collection('bills').add(bill.toMap());
  }

  Stream<List<Bill>> getBills() {
    return _db.collection('bills').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Bill(
        id: doc.id,
        name: doc['name'],
        amount: doc['amount'],
        dueDate: (doc['dueDate'] as Timestamp).toDate(),
        isPaid: doc['isPaid'],
      )).toList()
    );
  }

  Future<void> updateBillStatus(String id, bool isPaid) {
    return _db.collection('bills').doc(id).update({'isPaid': isPaid});
  }
}
