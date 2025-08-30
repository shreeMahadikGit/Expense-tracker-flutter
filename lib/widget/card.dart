

//import 'package:expense_tracker/widget/size.dart';
import 'package:expense_tracker/widget/inside_card.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column (

      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20) ,alignment: Alignment.topLeft, child: Text('Selected Card',style: TextStyle(fontWeight: FontWeight.bold, fontSize:16),)),
          Expanded(child:ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: PageScrollPhysics(),
          itemBuilder:(context,i){
          return Container(
            width: MediaQuery.of(context).size.width*0.9,
            padding: EdgeInsets.fromLTRB(0,0,0,0),
            margin: EdgeInsets.fromLTRB(20, 20, 10, 70),
            decoration: BoxDecoration(
              color: Color(0xffedf1f4),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade600,
                              offset: Offset(7, 7),
                              blurRadius: 5,
                              spreadRadius: 2),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-7, -7),
                            blurRadius: 5,
                            spreadRadius: 2,
                          )
                        ],
          ),
          child: Stack(
                      children: <Widget>[
                         Positioned.fill(
                          top: 150,
                          bottom: -200,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 50,
                                  spreadRadius: 2,
                                  offset: Offset(20, 0)),
                                   BoxShadow(
                                  color: Colors.white12,
          
                                  blurRadius: 0,
                                  spreadRadius: -2,
                                  offset: Offset(0, 0)),
                            ], shape: BoxShape.circle, color: Colors.white30),
                          ),
                        ),
                        Positioned.fill(
                          top: -100,
                          bottom: -30,
                          left: -300,
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.white60.withOpacity(0.2),
                                  blurRadius: 50,
                                  spreadRadius: 2,
                                  offset: Offset(20, 0)),
                                   BoxShadow(
                                  color: Colors.white12,
                                  blurRadius: 0,
                                  spreadRadius: -2,
                                  offset: Offset(0, 0)),
                            ], shape: BoxShape.circle, color: Colors.white30),
                          ),
                        ), 
                       
                        BankCard(),
                      ],
                    ),
          
          
          );
                } )),
      ]
    );
  }
}
