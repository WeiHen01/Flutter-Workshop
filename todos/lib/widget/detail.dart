import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  // const DetailPage({super.key});

  /**
    To pass the data forward
      1. In receiver (detail.dart), create a variable to store the received item
   */
  Map<String,dynamic> item;

  /**
   * 2. Create a constructor of the receiver class
   * 3. At The sender which is home.dart, it will send the item
   *    in Navigator.push

   */
  DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details Page"),),
      // here will display the data received from the sender (home.dart)
      body: Text("Detail Page for ${item["place"]!}")
    );
  }
}
