class Expense {
  final String id;
  final String description;
  final double amount;
  final String category;
  final DateTime date;
  final bool isBusiness;

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
    required this.isBusiness,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'amount': amount,
      'category': category,
      'date': date,
      'isBusiness': isBusiness,
    };
  }
}
