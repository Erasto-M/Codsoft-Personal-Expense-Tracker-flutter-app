// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class AddExpenseModel {
  final String title;
  final String amount;
  final String category;
  final DateTime? date;
  final String? id;
  final String? userId;
  AddExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    DateTime? date,
    this.id,
    this.userId,
  }) : date = date ?? DateTime.now();

  AddExpenseModel copyWith({
    String? title,
    String? amount,
    String? category,
    DateTime? date,
    String? id,
    String? userId,
  }) {
    return AddExpenseModel(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'amount': amount,
      'category': category,
      'date': DateFormat('dd-MM-yyyy').format(date!),
      'id': id,
      'userId': userId,
    };
  }

  factory AddExpenseModel.fromMap(Map<String, dynamic> map) {
    return AddExpenseModel(
      title: (map["title"] ?? '') as String,
      amount: (map["amount"] ?? '') as String,
      category: (map["category"] ?? '') as String,
      date: (map["date"] != null)
          ? DateFormat('dd-MM-yyyy').parse(map["date"] as String)
          : DateTime.now(),
      id: (map["id"] ?? '') as String,
      userId: (map["userId"] ?? '') as String,
    );
  }
}
