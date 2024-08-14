class Bill {
  final String id;
  final String name;
  final double amount;
  final DateTime dueDate;
  final bool isPaid;

  Bill({
    required this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'dueDate': dueDate,
      'isPaid': isPaid,
    };
  }
}
