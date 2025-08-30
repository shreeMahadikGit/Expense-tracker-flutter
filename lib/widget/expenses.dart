import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/data/expenselist.dart';
import 'package:expense_tracker/data/piechartdata.dart';
import 'package:expense_tracker/widget/piechart/piechart.dart';
import 'package:expense_tracker/widget/plusbutton.dart';
import 'package:expense_tracker/widget/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpensesWidget extends StatefulWidget {
  static var category;

  const ExpensesWidget({Key? key, required this.newTransaction})
      : super(key: key);
  final Function() newTransaction;

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

var user = FirebaseAuth.instance.currentUser!;

class _ExpensesWidgetState extends State<ExpensesWidget> {
  @override
  Widget build(BuildContext context) {
    //Database
    var user = FirebaseAuth.instance.currentUser!;
    final Stream<QuerySnapshot> transactions = FirebaseFirestore.instance
        .collection('expenses')
        .doc(user.uid)
        .collection('transactions')
        .snapshots();
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    double fontSize(double size) {
      return size * width / 414;
    }

    return StreamBuilder<QuerySnapshot>(
      stream: transactions,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return Center(child: Text('Something Went Wrong!'));
        }
        ;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final data = snapshot.requireData;
        double totalfood = 0;
        double totalEntertainment = 0;
        double totalPersonal = 0;
        double totalTransportation = 0;
        double totalStudies = 0;
        double totalAny = 0;

        for (var i = 0; i < data.docs[0]['transactions'].length; i++) {
          if (data.docs[0]['transactions'][i]['Category'] == 'Food') {
            totalfood += data.docs[0]['transactions'][i]['t_amt'];
          }
          if (data.docs[0]['transactions'][i]['Category'] == 'Entertainment') {
            totalEntertainment += data.docs[0]['transactions'][i]['t_amt'];
          }
          if (data.docs[0]['transactions'][i]['Category'] == 'Personal') {
            totalPersonal += data.docs[0]['transactions'][i]['t_amt'];
          }
          if (data.docs[0]['transactions'][i]['Category'] == 'Transportation') {
            totalTransportation += data.docs[0]['transactions'][i]['t_amt'];
          }
          if (data.docs[0]['transactions'][i]['Category'] == 'Studies') {
            totalStudies += data.docs[0]['transactions'][i]['t_amt'];
          }
          if (data.docs[0]['transactions'][i]['Category'] == 'Any') {
            totalAny += data.docs[0]['transactions'][i]['t_amt'];
          }
          AppColors(totalFood: totalfood);
        }
        return ListView(
          scrollDirection: Axis.horizontal,
          physics: PageScrollPhysics(),
          children: <Widget>[
            //Balance card
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffedf1f4)),
              child: Column(
                children: <Widget>[
                  Text('B A L A N C E',
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  SizedBox(height: 10),
                  Text(
                    '\₹' + data.docs[0]['Balance'].toString(),
                    style: TextStyle(color: Colors.grey[800], fontSize: 40),
                  ),
                  Text(
                    'Tap on Balance to edit balance',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Income',
                                    style: TextStyle(color: Colors.grey[500])),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    '\₹' +
                                        data.docs[0]['totalIncome'].toString(),
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Expense',
                                    style: TextStyle(color: Colors.grey[500])),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    '\₹' +
                                        data.docs[0]['totalExpense'].toString(),
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  PlusButton(
                    function: widget.newTransaction,
                  ),
                ],
              ),
            ),

            // transaction scroll
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffedf1f4)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'T R A N S A C T I O N S',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  data.docs[0]['transactions'].length == 1
                      ? Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: Text('No Transactions Yet'),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount:
                                  data.docs[0]['transactions'].length - 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 12.0, left: 10, right: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffedf1f4),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade600,
                                            offset: Offset(3, 3),
                                            blurRadius: 5,
                                            spreadRadius: 2),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-3, -3),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                        )
                                      ],
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[500]),
                                              child: Center(
                                                child: Icon(
                                                  Icons.attach_money_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                data.docs[0]['transactions']
                                                    [index + 1]['t_name'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[700],
                                                )),
                                          ],
                                        ),
                                        Text(
                                          (data.docs[0]['transactions']
                                                  [index + 1]['isIncome']
                                              ? '+' +
                                                  '₹' +
                                                  data.docs[0]['transactions']
                                                          [index + 1]['t_amt']
                                                      .toString()
                                              : '-' +
                                                  '₹' +
                                                  data.docs[0]['transactions']
                                                          [index + 1]['t_amt']
                                                      .toString()),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: data.docs[0]['transactions']
                                                    [index + 1]['isIncome']
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                ],
              ),
            ),

            //pie Chart
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffedf1f4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Monthly Expenses",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize(20)),
                        ),
                        Text('BETA',
                            style: TextStyle(fontSize: fontSize(10))),
                      ]),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: AppColors.category.map((data) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: AppColors.pieColors[AppColors
                                                .category
                                                .indexOf(data)],
                                            shape: BoxShape.circle),
                                      ),
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                          fontSize: fontSize(16),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: PieChart(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
