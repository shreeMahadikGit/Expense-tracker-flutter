import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/data/expenselist.dart';
import 'package:expense_tracker/widget/expenses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class transaction extends StatefulWidget {
  const transaction({Key? key}) : super(key: key);

  @override
  _transactionState createState() => _transactionState();
}

class _transactionState extends State<transaction> {
  bool _isIncome = false;
  final _textcontrollerNAME = TextEditingController();
  final _textcontrollerAMOUNT = TextEditingController();
  late String _currentCategeory;
  final _formKey = GlobalKey<FormState>();
  final String dropdownvalue = 'Any';
  final items = [
    'Food',
    'Entertainment',
    'Personal',
    'Transportation',
    'Studies',
    'Any'
  ];

  String? value;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );



ReadTransaction(
    {required String t_name,
      required String t_amt,
      required String Category,
      required bool  isIncome})
 {
    var user = FirebaseAuth.instance.currentUser!;
    final docUser =
    FirebaseFirestore.instance.collection('expenses')
    .doc(user.uid).collection('transactions').doc('transactions');
        
      Map<String, dynamic>transaction(String t_name, String t_amt,String category,bool isIncome){
      double t_amtdouble = double.parse(t_amt);
      if (isIncome == false){
        t_amtdouble= double.parse('-'+ t_amt );
      }
      if (isIncome == true){
         return
      {
        'transactions': FieldValue.arrayUnion([
          {
            "t_name": t_name,
            "t_amt": t_amtdouble,
            "Category": Category,
            "isIncome":isIncome,
          },
        ]),
        
        
        'totalIncome':FieldValue.increment(t_amtdouble), 
        'Balance':FieldValue.increment(t_amtdouble),
      };
      }
      else{
          return
      {
        'transactions': FieldValue.arrayUnion([
          {
            "t_name": t_name,
            "t_amt": t_amtdouble,
            "Category": Category,
            "isIncome":isIncome,
          },
        ]),
        
        
        'totalExpense':FieldValue.increment(t_amtdouble), 
        'Balance':FieldValue.increment(t_amtdouble),
      };
      }
    
  }

  docUser.update(transaction(t_name, t_amt, Category,  isIncome));
  }


  @override
  Widget build(BuildContext context) {
     return Form(
        key: _formKey,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Enter Transaction details'),
        SizedBox(height:10),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'What Did you spent on ?',
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Enter an Item name';
            }
            return null;
          },
          controller: _textcontrollerNAME,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'How much did you spent ?',
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Enter an Amount';
            }
            return null;
          },
          controller: _textcontrollerAMOUNT,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Category'),
            DropdownButton<String>(
              value: value,
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) => setState(() {
                _currentCategeory = value.toString();
                this.value = value;
              }),

            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Expense'),
            Switch(
              value: _isIncome,
              onChanged: (newValue) {
                setState(() {
                  _isIncome = newValue;
                });
              },
            ),
            Text('Income')
          ],
        ),
     
     
     
     
     
     
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ReadTransaction(
                    t_name: _textcontrollerNAME.text,
                    t_amt: (_textcontrollerAMOUNT.text),
                    Category: _currentCategeory,
                    isIncome: _isIncome);
                
                
                
                Navigator.pop(context);
     
     
     
     
     
              }
            },
            child: Text('Submit'))
      ],
        ),
     );
  }
}
