import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // default color for material design
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  // 2) need to declare variable here before widget build
  // for obtaining value from text field
  // for each text field create texteditingcontroller
  var nameEditingController = TextEditingController();
  // const HomePage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow, //background color
        appBar: AppBar(title: Text("Hello World"), backgroundColor: Colors.orange,), //app bar
        //Center(): to set the text to be centered
        //textAlign
        //fontFamily
        //Column for table
        // SingleChildScrollView
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Center(child: Column(
            children: [
              // text with styling
              Text("Welcome to my app", style: TextStyle(color: Colors.green, fontSize: 32, fontWeight: FontWeight.bold),),

              //margin as a spacing between text and image
              // separate vertically
              SizedBox(height: 8),

              //here is put the image from network with url
              Image.network("https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/4e/53/27/4e532722-cbef-d4a3-9970-1c6b772d19cb/mzl.kdlmbkug.jpg/375x375bb.jpg"),
              SizedBox(height: 8),

              Text("女神 卓文萱", style: TextStyle(color: Colors.black, fontSize: 24)),
              SizedBox(height: 8),

              Text("Genie Chuo", style: TextStyle(fontSize: 20)),

              Text("Please enjoy my app", style: TextStyle(color: Colors.black, fontSize: 24)),
              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("This is left", style: GoogleFonts.poppins(fontSize: 30)),

                  // sizedBox width for separating text in horizontal
                  SizedBox(width: 20),
                  Text("This is right")
                ],
              ),
              // hintText is the placeholder for input field
              TextField(decoration: InputDecoration(hintText: "Enter your name"), controller: nameEditingController,),
              TextButton(onPressed: (){
                // print the value received from the input on text field
                // by declaring ${controllerVariable.text}
                Fluttertoast.showToast(
                    msg: "Hello ${nameEditingController.text}",
                    toastLength: Toast.LENGTH_SHORT, //toast display duration
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );;
              }, child: Text("Press me")),
            ],
          ),
          ),
        )
    );
  }
}

