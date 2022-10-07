import 'package:flutter/material.dart';
import './listy.dart';
import './transaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import './chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'expense Report'),
      title: 'expenses',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.purple,
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _handleChange() {
    print("func_ entered");
    var ttl = controller_title.text;
    var amt = double.parse(controller_amount.text);
    if (ttl.isEmpty || amt <= 0) return;
    Navigator.pop(context);
    controller_amount.clear();
    controller_title.clear();
    var t2 = Transaction(date_of_purchase: dat, amount: amt, title: ttl);
    setState(() {
      listi.add(t2);
    });
    dat = DateTime.now();
  }

  var dat = DateTime.now();
  DateTime date = DateTime.now();
  List<Transaction> listi = [];
  void choosing_date() {
    setState(() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2025))
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          dat = pickedDate;
        });
      });
    });
  }

  // void _startAddNewTransaction(BuildContext context) {}
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          // onTap: () {},
          // child: NewTransaction(_addNewTransaction),
          // child: Text("modal coder"),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller_title,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // labelText: 'Enter Name',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1.5, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.amber),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter Your Name'),
                  onSubmitted: (_) => {_handleChange()},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: controller_amount,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1.5, color: Colors.purple),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.yellow),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Enter the amount',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  style: TextStyle(color: Colors.black),
                  onSubmitted: (_) => {_handleChange()},
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      child: Text(DateFormat.yMMMEd().format(dat)),
                    ),
                    ElevatedButton(
                      onPressed: choosing_date,
                      child: Text('choose date'),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: _handleChange,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.purple, width: 1),
                    backgroundColor: Color(0xffffff99),
                  ),
                  child: Text(
                    "save",
                    style: TextStyle(color: Colors.purple, fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
          // behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void delete(Transaction t1) {
    print("removed ${t1.title} ");
    setState(() {
      listi.remove(t1);
    });
  }

  PreferredSizeWidget buildappbar() {
    return AppBar(
      title: Center(child: Text(widget.title)),
      actions: [
        IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: const Icon(
              color: Colors.purple,
              Icons.add,
            ))
      ],
    );
  }

  int _counter = 0;
  final controller_title = TextEditingController();
  final controller_amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomPadding: false,
        appBar: buildappbar(),
        body: listi.isEmpty
            ? Center(
                child: Column(
                  children: [
                    Text(
                      "No transactions yet",
                      style: TextStyle(fontSize: 28),
                    ),
                    Container(
                      height: 400,
                      width: 200,
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset(
                        'assestZ/waiting.png',
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    // height: 100,
                    child: Chart(listi),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.black),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * (0.6),
                      // width: 300,
                      child: ListView.builder(
                          // scrollDirection: Axis.horizontal,
                          itemCount: listi.length,
                          itemBuilder: (BuildContext context, int index) {
                            return listy(listi[index], delete);
                          })),
                  // card(),
                ],
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
