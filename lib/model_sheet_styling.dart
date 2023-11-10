import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/model/expense.dart';
final formatter=DateFormat.yMd();

class ModelSheet extends StatefulWidget{
  const ModelSheet ({super.key , required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<ModelSheet> createState(){
    return  _ModelSheetState();
  }
}

class _ModelSheetState extends State<ModelSheet>{
  final _titleController=TextEditingController();
  final _amountController=TextEditingController();


  DateTime? _selectDate;
  void _presentDatePicker() async {
    final now=DateTime.now();
  final firstDate=DateTime(now.year-1,now.month,now.day);
    final pickedDate= await showDatePicker(context: context, initialDate:now , firstDate: firstDate, lastDate: now);
    setState(() {
      _selectDate=pickedDate;
    });
  }

  void _submittedExpenseData(){
    final enteredAmount=double.tryParse(_amountController.text);
    final amountInValid=enteredAmount==null || enteredAmount <=0;
    if(_titleController.text.trim().isEmpty || amountInValid || _selectDate==null){
      showDialog(context: context, builder: (ctx)=>AlertDialog(
        title: Text('Invalid input'),
        content: Text('Please make sure to put valid data'),
        actions: [TextButton(onPressed:() {Navigator.pop(ctx);}, child: Text('Okey'))],
      )
      );
      return;
    }
    widget.onAddExpense(Expense(amount: enteredAmount,title: _titleController.text,date: _selectDate!,category: _selectedCategory));
    Navigator.pop(context);
  }

  Categoryy _selectedCategory=Categoryy.leisure;

  @override
  void dispose(){
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Widget build(context) {
    return Padding(padding:const  EdgeInsets.fromLTRB(16, 48, 16, 16),
    child: Column(children: [
      TextField(
        controller: _titleController,
        maxLength: 50,
      decoration: const InputDecoration(label: Text('Title')),),
      Row(children: [Expanded(
        child: TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefix: Text('\$'),
            label: Text('Amount')),
        ),),
        const SizedBox(width: 16,),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text(_selectDate==null?'no date selected':formatter.format(_selectDate!)),
            IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month))
          ],),
        ),]),
      Row(children: [
        DropdownButton(
          value: _selectedCategory,
          items: Categoryy.values.map((Categoryy) => DropdownMenuItem(
          value: Categoryy,
          child: Text(Categoryy.name.toString()))).toList(),
          onChanged: (value){
            if(value==null){
              return;
            }
            setState(() {
              _selectedCategory=value;
            });
          }),
          const Spacer(),
        
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text('cancle')),
        ElevatedButton(onPressed: (){
          _submittedExpenseData();}, child: Text('Save')),
                ],)
      
    ],),);
  }
}