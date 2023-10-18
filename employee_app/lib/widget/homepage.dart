import 'dart:convert';

import 'package:employee_app/models/employee.dart';
import 'package:employee_app/widget/add.dart';
import 'package:employee_app/widget/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _employee = [];

  @override
  void initState(){
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


@override
  Widget build(BuildContext context) {
  return Scaffold(

    /**
     * Floating Action Button
     */
  floatingActionButton: FloatingActionButton(
      onPressed: () async{
        // Add your logic here for the action you want the button to perform.
        var item = await Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              AddPage(),),);

        if(item != null){
          print(item);
        }
      },
      child: Icon(Icons.add),
    ),

    appBar: AppBar(
      title: Text("Employee"),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 25,),
      backgroundColor: Colors.red,
    ),
    body: ListView.builder(
      itemCount: _employee.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: ListTile(
                title: Text(_employee[index].name),
                subtitle: Text(_employee[index].department),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  /**
                   * Pass data forward from detail.dart -->  home.dart
                   * --------------------------------------------------------
                   * 2. Create a constructor of the receiver class
                   * 3. At The sender which is "home.dart", it will send the
                   *    item in Navigator.push.
                   */
                 Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(id:_employee[index].id)
                      ));
                }
            )
        );
      },),
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
Future<List<Employee>> fetchEmployees() async {
  // 10. Fix with following import
  // import 'package:http/http.dart' as http
  final response = await http
      .get(Uri.parse('https://api.sheety.co/ff77fdea49c96b936b241f37866fc348/sheetyApi/sheet1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    // 11. If you are working with [] -> It will be xxxxsFromJson
    // If you are working with {} -> It will be fromJson
    return Employee.employeesFromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
