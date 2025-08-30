import'package:cloud_firestore/cloud_firestore.dart';
Future SetTransaction(
      {
      required String uid, 
      required String t_name,
      required String t_amt,
      required String Category,
      required bool isIncome}) async {
    final docUser =
    FirebaseFirestore.instance.collection('expenses')
    .doc(uid).collection('transactions').doc('transactions');
        
      Map<String, dynamic>transaction(String t_name, String t_amt,String category,bool isIncome){
      double t_amtdouble = double.parse(t_amt);
      if (isIncome == false){
        t_amtdouble= double.parse('-'+ t_amt );
      } 
    double totalIncome=0.0;
      
    double totalExpense=0.0;
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
        'totalIncome': totalIncome,
        'totalExpense': totalExpense,
        'Balance':FieldValue.increment(t_amtdouble),
      };
  }

    await docUser.set(transaction(t_name, t_amt, Category, isIncome));  
  }



