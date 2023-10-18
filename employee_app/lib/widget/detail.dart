import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/employee.dart';

import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  //const DetailPage({super.key});

  /**
   * To pass the data forward from detail.dart --> home.dart
   * ------------------------------------------------------------------
   * 1. In receiver (detail.dart), create a variable to store the received item
   */
  int id;

  /**
   * To pass the data forward from detail.dart --> home.dart
   * ------------------------------------------------------------------
   * 2. Create a constructor of the receiver class
   * 3. At The sender which is home.dart, it will send the item
   *    in Navigator.push
   */
  DetailPage({required this.id});


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  Employee? _employee;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  void loadData()
  {
    fetchEmployees().then((value) => {
      setState(()
      {
        _employee =  value;
      }
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
       * for Stateful screen, to display the data use ${widget.item}
       */
        appBar: AppBar(title: Text("Add Detail Page")),
        body: _employee == null? Center(child: CircularProgressIndicator()) :

            Column(
              children: [
                Text(_employee!.name),
                Text(_employee!.email),
                Text(_employee!.department),
                Text(_employee!.address),
              ],
            )
    );
  }
}

/*
  Fetching Data from HTTP
  ------------------------
  9. Copy the API about "Convert the http.Response to an Album" at flutter documentation
  Future -> The keyword Future here means this is an asynchronous method

  **Special Case - calling function asynchronous
  ---------------------------------------------------
  If you are working with method that has Future
      1 -> Use "async" "await" to call this method
      2 -> Use then...

      First way: var employees = async fetchEmployees()
      Second way: initState(){
                      super.initState();
                      loadData();
                  }

                  void loadData() {
                      fetchEmployees().then((value) => {
                         setState((){
                            _employee = value;
                         })
                      });
                  }
  ---------------------------------------------------


  <data_type> -> The data type that is gong to be returned by the API
  --> If you are working with [] => It will be List<ClassName>
  --> If you are working with {} => It will be <ClassName>
 */
Future<Employee> fetchEmployees() async {
  // 10. Fix with following import
  // import 'package:http/http.dart' as http
  final response = await http
      .get(Uri.parse("https://api.sheety.co/ff77fdea49c96b936b241f37866fc348/sheetyApi/sheet1/${Widget.id}"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    // 11. If you are working with [] -> It will be xxxxsFromJson
    // If you are working with {} -> It will be fromJson
    return Employee.fromJson(jsonDecode(response.body)["sheet1"]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
