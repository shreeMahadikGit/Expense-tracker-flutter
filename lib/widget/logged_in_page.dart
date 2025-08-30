import 'package:expense_tracker/widget/custom_appbar.dart';
import 'package:expense_tracker/widget/expenses.dart';
import 'package:expense_tracker/widget/transactionform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'card.dart';
import 'expenses.dart';

class LoggedInWidget extends StatefulWidget{
  @override
  State<LoggedInWidget> createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  late String _t_name;
  late String _t_amt;
  late bool isExpense = false;
  final _formKey = GlobalKey<FormState>();
  final List<String> _category = ['Food','Entertainment','Personal','Transportation','Studies','Any'];

  void _newTransaction(){
    showDialog(context: context, 
    builder: (BuildContext context){
     return SimpleDialog(
       title: Text('Select a Option'),
       children:<Widget>[
         SimpleDialogOption(
           padding: EdgeInsets.symmetric(horizontal: 24,vertical: 14),
           onPressed: (){ 
              _CreditCard();
           },
           child: Text('New Credit Card' + '   (Available Soon)'),
         ),
         SimpleDialogOption(
           padding: EdgeInsets.symmetric(horizontal: 24,vertical: 14),
           onPressed: (){ 
             Navigator.pop(context);
             return _Transaction();
           },
           child: Text('New Transaction'),
         ),
       ],
     );
    });
    }

  void _Transaction(){
    showDialog(context: context, builder:(context){
      return AlertDialog(
      content:transaction(),
     contentPadding: const EdgeInsets.all(20.0)
      );
    });
  }

  void _CreditCard(){

  }

  @override
  Widget build(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser!;

      return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color(0xffedf1f4),
      body: Column(
        children: [
            Container(
              height: 120,
            child: CustomAppBar(),
            ),
            Expanded(child:CardWidget()),
            Expanded(child: ExpensesWidget(newTransaction: () { _newTransaction(); },))
        ],
        )
       );


  }
}