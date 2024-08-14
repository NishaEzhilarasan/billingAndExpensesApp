import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_expense_tracker/models/expense_model.dart';


class ExpenseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addExpense(Expense expense) {
    return _db.collection('expenses').add(expense.toMap());
  }

  Stream<List<Expense>> getExpenses() {
    return _db.collection('expenses').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Expense(
        id: doc.id,
        description: doc['description'],
        amount: doc['amount'],
        category: doc['category'],
        date: (doc['date'] as Timestamp).toDate(),
        isBusiness: doc['isBusiness'],
      )).toList()
    );
  }
}
