import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  // Need to comment out this for linking
  // const AddPage({super.key});

  // 2. Each text field needs to have an TextEditingController()
  var nameEditingController = TextEditingController();
  var descController = TextEditingController();
  var placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Page"),
        backgroundColor: Colors.indigo,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 30,
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
           TextField(
             decoration: InputDecoration(
               border: OutlineInputBorder(),
                 hintText: "Enter todo name",
                 labelText: "Enter todo name",
             ),
                 controller: nameEditingController,
           ),

            SizedBox(height: 18),

            /**
             * 1. Create text fields
             * 2. Declare TextEditingController for each text field
             *    at the upper line before Widget build.
             * 3. Link every TextEditingController with respective text field
             */

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                  hintText: "Enter todo description",
                  labelText: "Enter todo description",
              ),

              controller: descController,
            ),

            SizedBox(height: 18),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                  hintText: "Enter todo place",
                  labelText: "Enter todo place",

              ),
              controller: placeController,
            ),

            SizedBox(height: 18),

            TextButton(onPressed: (){
              print(nameEditingController.text);
              print(descController.text);
              print(placeController.text);


              /**
               * Get back data from sender (add.dart)
              * 3. In the sender (add.dart) you will pass back the data
               *    as the second argument using Navigator.pop
               */
              var newItem = {
                "name": nameEditingController.text,
                "desc": descController.text,
                "place": placeController.text,
              };

              // It will go back to previous page
              Navigator.pop(context, newItem);

            }, child: Text("Add new item"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.yellow),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            )),
          ],
        ),
      ),
    );
  }
}




