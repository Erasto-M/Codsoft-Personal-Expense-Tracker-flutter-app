class AddExpenseModel {
  final String title;
  final String amount;
  final String category;
  final DateTime? date;
  final String id;
  final String userId;
  AddExpenseModel({
    required this.amount,
    required this.category,
    required this.title,
    this.id = '',
    this.userId = '',
    DateTime? date,
  }) : date = DateTime.now();
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Title': title,
      'Amount': amount,
      'Category': category,
      'date': date,
      'Id': id,
      'Uid': userId,
    };
  }

  factory AddExpenseModel.fromMap(Map<String, dynamic> map) {
    return AddExpenseModel(
      amount: map['Amount'] as String,
      category: map['Category'] as String,
      title: map['Title'] as String,
      date: map['date'],
      id: map['id'] as String,
      userId: map['Uid'] as String
    );
  }
  AddExpenseModel copyWith({
    String? title,
    String? amount,
    String? category,
    DateTime? date,
    required String id,
    required String userId,
  }) {
    return AddExpenseModel(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      title: title ?? this.title,
      id: id,
      userId: userId,
      date: date ?? this.date,
    );
  }
}
