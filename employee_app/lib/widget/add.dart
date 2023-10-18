import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  // Need to comment out this for linking
  // const AddPage({super.key});

  // 2. Each text field needs to have an TextEditingController()
  var nameEditingController = TextEditingController();
  var emailController = TextEditingController();
  var departController = TextEditingController();
  var addressController = TextEditingController();

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
                hintText: "Enter name",
                labelText: "Enter name",
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
                hintText: "Enter email",
                labelText: "Enter email",
              ),

              controller: emailController,
            ),

            SizedBox(height: 18),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter department",
                labelText: "Enter department",

              ),
              controller: departController,
            ),

            SizedBox(height: 18),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter address",
                labelText: "Enter address",

              ),
              controller: addressController,
            ),

            SizedBox(height: 18),

            ElevatedButton(onPressed: (){
              print(nameEditingController.text);
              print(emailController.text);
              print(departController.text);
              print(addressController.text);

              /**
               * Get back data from sender (add.dart)
               * 3. In the sender (add.dart) you will pass back the data
               *    as the second argument using Navigator.pop
               */
              var newItem = {
                "name": nameEditingController.text,
                "email":emailController.text,
                "department":departController.text,
                "address":addressController.text,
              };

              // It will go back to previous page
              Navigator.pop(context, newItem);

            }, child: Text("Add new employee"),
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





