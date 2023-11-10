import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget{
  const ExpensesItem (this.expense,{super.key});
  final Expense expense;
  @override
  Widget build(context) {
    return Card(child: 
      Padding(
        padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
        SizedBox(height: 16,),
        Row(children: [
          Text('\$ ${expense.amount.toStringAsFixed(2)}'),
          const Spacer(),
          Row(
            children:[
          Icon(CategoryIcons[expense.category]),
          Text(expense.formatterDate)],)
        ],)
      ]),));
  }
}