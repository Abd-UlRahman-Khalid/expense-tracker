import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
final uuid=Uuid();
final formatter=DateFormat.yMd();
enum Categoryy {food,travel,leisure,work}

const CategoryIcons={
  Categoryy.travel:Icons.flight_takeoff,
  Categoryy.food:Icons.lunch_dining,
  Categoryy.leisure:Icons.movie,
  Categoryy.work:Icons.work,
};

class Expense{
  Expense({required this.title,required this.date,required this.amount,required this.category}):id=uuid.v4();
  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Categoryy category;
  String get formatterDate{
    return formatter.format(date);
  }

}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Categoryy category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}