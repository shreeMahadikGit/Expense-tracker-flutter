import 'package:expense_tracker/data/piechartdata.dart';
import 'package:expense_tracker/widget/expenses.dart';
import 'package:expense_tracker/widget/piechart/paintpiechart.dart';
import 'package:flutter/material.dart';
import '../size.dart';


class PieChart extends StatefulWidget {
  
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
    with SingleTickerProviderStateMixin {
  double total = 0;
  @override
  void initState() {
    super.initState();
   AppColors.category.forEach((e) => total += e['amount']);
  }

  @override
  Widget build(BuildContext context) {

    var width = SizeConfig.getWidth(context);
    double fontSize(double size) {
      return size * width / 414;
    }

    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              shape: BoxShape.circle,
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
                        ]),
          child: Stack(
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.6,
                  child: CustomPaint(
                    child: Container(),
                    foregroundPainter: PieChartCustomPainter(
                        width: constraint.maxWidth * 0.5,
                        categories: AppColors.category,
                       ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: constraint.maxWidth * .5,
                  decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                         BoxShadow(
                              color: Colors.grey.shade600,
                              offset: Offset(2, 2),
                              blurRadius: 5,
                              spreadRadius: 2),               
                      ]),
                  child: Center(
                      child: Text(
                    "\₹" + total.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: fontSize(22)),
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
