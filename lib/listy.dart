import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

// import "string_extension.dart";
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class listy extends StatelessWidget {
  final Transaction t1;
  final Function fun;

  listy(this.t1, this.fun);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // Text("data"),
        Row(
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                      child: Text(
                    "\$" + t1.amount.toStringAsFixed(1),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.purple, style: BorderStyle.solid, width: 2),
                  // shape: BoxShape.circle,
                  // color: Colors.purple,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t1.title.toCapitalized(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMEd().format(t1.date_of_purchase),
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ],
        ),

        Container(
          child: IconButton(
              icon: Icon(
                Icons.delete_outlined,
                semanticLabel: "delete",
                size: 36,
              ),
              onPressed: () {
                fun(t1);
              },
              color: Colors.black),
        )
   
      ]),
    );
  }
}
