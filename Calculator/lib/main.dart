import 'package:flutter/material.dart';
import 'dart:math';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: bmi_calc(),
    );
  }
}

class bmi_calc extends StatefulWidget {
  const bmi_calc({super.key});

  @override
  State<bmi_calc> createState() => _bmi_calcState();

}

class _bmi_calcState extends State<bmi_calc> {

  // setting default value for the sliders
  double _heightSliderValue = 170;
  double _weightSliderValue = 70;

  var _bmi = 0;
  var _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator"),
        titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 25,
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text("BMI Calculator", style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 50,
              ),
              ),
              Image.network("https://www.cdc.gov/healthyweight/images/assessing/"
                  "bmi-adult-fb-600x315.jpg"),
              Text("We care about your health", style: TextStyle(fontSize: 24)),

              //${_heightSliderValue.round()} is to print value received from
              Text("Height (${_heightSliderValue.round()} cm)", style: TextStyle(fontSize: 18)),
              Slider(
                value: _heightSliderValue,
                max: 200,
                onChanged: (double value) {
                  setState(() {
                    _heightSliderValue = value;
                  });
                },
              ),
              Text("Weight (${_weightSliderValue.toStringAsFixed(2)} kg)", style: TextStyle(fontSize: 18)),
              Slider(
                value: _weightSliderValue,
                max: 200,
                onChanged: (double value) {
                  setState(() {
                    _weightSliderValue = value;
                  });
                },
              ),

              /**
               * Conditional Rendering
               * (condition ) ?  (true statement) : (false statement)
               * If (condition) then (true statement) if not (false statement)
               */

              /**
               * Here's the condition:
               * 1. if BMI < 18 or BMI > 25 ---> the display text will be in red
               * 2. else the display text is green
               */
              _bmi != 0 ? Text("Your BMI is ${_bmi}",
                style: _bmi < 18 || _bmi > 25 ? TextStyle(color: Colors.red)
                    : _bmi < 23 && _bmi > 20 ? TextStyle(color: Colors.blue)
                    :TextStyle(color: Colors.green),)
                  : SizedBox(),

              // text to display the calculation of BMI value
              //Text("Your BMI is ${_bmi}"),

              // display whether the user is normal, underweight or overweight
              // based on BMI value calculations after the button is pressed
              Text("${_message}"),

              SizedBox(height:18),

              TextButton.icon(onPressed:(){

                // function to calculate BMI
                // BMI = weight in kg / (height in m)^2
                var bmi_Temp = _weightSliderValue / pow((_heightSliderValue/100),2);
                print(bmi_Temp.toStringAsFixed(2) + "cm kg^-1");

                // In Flutter and React Native, this means assigning the value bmiTemp.round in _bmi
                // but without Refresh the UI
                // _bmi = bmi_Temp.round();


                /**
                 * Add another text in the UI that will message according to user's BMI
                 * 1. BMI << 18: You are underweight
                 * 2. 18 << BMI << 25: You are normal
                 * 3. 25 << BMI << 30: You are overweight
                 * 4. BMI >> 30: You are obese
                 */
                /**
                 * Testing to know
                 */
                var _msgTemp = "";

                if(bmi_Temp.round() < 18) {
                  _msgTemp = "You are underweight";
                }
                else if(bmi_Temp.round() < 25 && bmi_Temp.round() >= 18) {
                  _msgTemp = "You are normal";
                }
                else if(bmi_Temp.round() < 30 && bmi_Temp.round() >= 25) {
                  _msgTemp = "You are overweight";
                }
                else
                {
                  _msgTemp = "You are obese";
                }


                // setState() is for updating by refreshing the value on UI interface
                // setState() is useful to change the value according to user's input
                // stateless is for without have any interaction
                // in order to do so, at the beginning, it must be stateful (stful)
                // In Flutter and React Native, this means assigning the value AND Refresh the UI
                setState(() {
                  _bmi = bmi_Temp.round();
                  _message = _msgTemp;
                });

              }, icon: Icon(Icons.favorite), label: Text("Calculate BMI"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


