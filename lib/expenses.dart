import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/model_sheet_styling.dart';
import 'package:expense_tracker/widget/chart.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});


  @override
  State<Expenses> createState(){
    return _ExpensesState();
  }
}


class _ExpensesState extends State<Expenses>{
  final List<Expense>_reqisteredExpenses=[
    Expense(title: 'Flutter Course', date: DateTime.now(), amount: 19.9, category: Categoryy.work),
    Expense(title: 'Cinema', date: DateTime.now(), amount: 15.3, category: Categoryy.leisure)
  ];

    void _openModelSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
      context:context, builder: (ctx) =>  ModelSheet(onAddExpense: _addExpense));
  }
  void _addExpense(Expense expense){
    setState(() {
      _reqisteredExpenses.add(expense);
    });
  }
  void _removeExpense(Expense expense){
    final expensIndex=_reqisteredExpenses.indexOf(expense);
    setState(() {
      _reqisteredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense Deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'Undo',textColor: Colors.yellow, onPressed: (){
          setState(() {
            _reqisteredExpenses.insert(expensIndex, expense);
          });
        }),
    ));
  }
  
  @override
  Widget build(context) {
    final width=MediaQuery.of(context).size.width;
    Widget mainContent=const Center(child: Text('There is no Content yet , Start Adding Some!'),);
    if(_reqisteredExpenses.isNotEmpty){
      mainContent=ExpensesList(
            expenses: _reqisteredExpenses,
            onRemoveExpense: _removeExpense
            );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: _openModelSheet, icon: const Icon(Icons.add),)],
        title: const Text('Flutter Expenses Tracker'),
      ),
      body:
      width<600? Column(children: [
        Chart(expenses: _reqisteredExpenses),
        Expanded(child:mainContent
          )
      ]):Row(children: [
        Expanded(child: Chart(expenses: _reqisteredExpenses)),
        Expanded(child:mainContent
          )
      ],)
    );
  }
}