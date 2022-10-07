class Transaction {
  final String title;
  final double amount;
  DateTime date_of_purchase;
  final t = DateTime(2017, 9, 7, 17, 30);
  // final String ;
  Transaction(
      {this.title = "madha", this.amount = 78, required this.date_of_purchase});
}
