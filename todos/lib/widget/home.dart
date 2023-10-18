import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todos/widget/add.dart';
import 'package:todos/widget/detail.dart';

import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /**
   * Items to be displayed in list
   */

  List<dynamic> _todos = [{
    "name":"Multiple page",
    "desc":"How to structure multiple page",
    "place":"Amphi"},
    {
      "name":"Navigation",
      "desc":"Simple , pass data forward, pass data backward",
      "place":"Amphi"
    },
    {
      "name":"ListView",
      "desc":"ListView, ListTile and Card",
      "place":"Amphi"
    },
    {
      "name":"Dinner",
      "desc":"Nasi Ayam Amyra rusli",
      "place":"Ee ji ban, Melaka Raya"
    },
    {
      "name":"Shared Preference",
      "desc":"Save and restore data",
      "place":"Amphi"
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async{
    // Obtain shared preferences.
    // load the file manager
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var todosString = prefs.getString("todos");
    if (todosString != null){
      var todos = jsonDecode(todosString);
      setState(() {
        _todos = todos;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          backgroundColor: Colors.indigo,
          titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold,
            fontSize: 30,
          ),



          actions: [
            IconButton(onPressed: () async{
              // the function to press and go to the next page
              // when the user press the "add" icon button
              // it will navigate to add page

              /**
               * Get back data from sender (add.dart)
               * 1. WAIIIIIIIIT for this page to finish and receive the item passed
               *    by adding "await"
               * 2. If using "await" keyword, you need to add "async" keyword
               *    to the nearest function {}. Here is onPressed() function
               * 3. In the sender (add.dart) you will pass back the data
               *    as the second argument using Navigator.pop
               */
              var passedItem = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()));

              /**
               * 4. Process the retrieved item
               */

              if(passedItem != null) {
                  _todos.add(passedItem);

                  // Obtain shared preferences.
                  // Get the file manager
                  final SharedPreferences prefs = await SharedPreferences.getInstance();

                  // Save as string
                  // SharedPreferences can store data types: String, int, bool, double, List<String>
                  // For other data type, has to transform to String
                  // Use jsonEncode to transform List of Map here to String
                  prefs.setString("todos", jsonEncode(_todos));


                  // refresh UI
                  setState(() {
                    _todos;
                  });
              }
            }, icon: Icon(Icons.add), style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ))
          ],),

        /**
         * List view to display the item
         */
        body: ListView.builder(
            padding: const EdgeInsets.all(15),

            // Numbers of items in the map or list
            // How many rows are there -> how many items in the list
            // The length of the list
            itemCount: _todos.length,

            // What to show for each row / index
            /** For each row/index I will show a Container/div of height 50
             *  of color amber.
             *
             *  Inside the container show a centered text showing the _todos
             *  at that position.
             *
             *  List View
             */
            /* itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              //background of the list box
              color: Colors.amber,

              // display the element "name" only for all items
              // from the dynamic list
              child: Center(
                  child: Text(_todos[index]["name"]!),
              ),
            );
          }
      ),*/

            /**
             * List Tile
             */
            /*itemBuilder: (BuildContext context, int index) {
              return widget(
                child: ListTile(
                  title: Text(_todos[index]["name"]!),
                  subtitle: Text(_todos[index]["place"]!),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DetailPage()));
                  },
                ),
              );
            }*/

            /**
            Card
             */
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                title: Text(_todos[index]["name"]!),
                subtitle: Text(_todos[index]["place"]!),
                trailing: Icon(Icons.chevron_right),
                onTap:(){
                  /**
                   * passing data step 3
                   * In sender , which is home.dart will send the item
                   * in Navigator.push in constructor
                   */
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                    item: _todos[index],
                  )));
                  }
                ),
              );
            }
        ),
    );
  }
}

