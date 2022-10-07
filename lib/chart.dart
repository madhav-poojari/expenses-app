import "package:flutter/material.dart";
import './transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  // const chart({Key? key}) : super(key: key);
  List<Transaction> listi;
  num total = 0;
  int count = -1;
  List<num> cost = [0, 0, 0, 0, 0, 0, 0];
  // final listi = [2, 3];
  Chart(this.listi) {
    for (int i = 0; i < 7; i++) {
      for (var x in listi) {
        if (x.date_of_purchase.day ==
            DateTime.now().subtract(Duration(days: i)).day) cost[i] += x.amount;
      }
      total += cost[i];
      print(cost[i]);
    }
    print(total);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: cost.map((e) {
                count++;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(" ${e}"),
                      Stack(
                        // fit: BoxFit.fitHeight,
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            width: 30,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(4))),
                          ),
                          Container(
                            width: 30,
                            height: 100 * (e / total),
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8))),
                          )
                        ],
                      ),
                      Text(count == 0
                          ? "today"
                          : DateFormat.E()
                              .format(DateTime.now()
                                  .subtract(Duration(days: count)))
                              .substring(0, 3)),
                    ],
                  ),
                );
              }).toList()),
          Center(
              child: Text(
            "spent \$${total} this week",
            style: TextStyle(fontSize: 30),
          ))
        ],
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(0xffffff99)),
    );
  }
}
