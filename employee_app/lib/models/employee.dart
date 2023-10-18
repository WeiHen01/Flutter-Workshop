import 'dart:convert';

import 'package:flutter/material.dart';

/**
 * Fetching Data from HTTP
 * ------------------------------------------------------
 * 1. Go pub.dev to obtain HTTP library to pubspec.yaml
 * 2. Create folder named "models"
 * 3. Create dart file named "employee"
 */

/*
  Fetching Data from HTTP
  ------------------------
  4. Create the class
 */
class Employee
{
  /*
    Fetching Data from HTTP
    ------------------------
   */
  // 5. Create the properties <- The property needs to be tally with info
  //    from API but comelCase (small at front, capital at back)
  final int id;
  final String name;
  final String email;
  final String address;
  final String department;

  /*
    Fetching Data from HTTP
    ------------------------
   */
  // 6. Create the constructor
  Employee({required this.id, required this.name, required this.email,
  required this.address, required this.department});

  /*
    Fetching Data from HTTP
    ------------------------
   */
  // 7. Create JSON to Object transformer
  factory Employee.fromJson(Map<String, dynamic> json)
  {
    // json["attribute"]: the attribute must follows the JSON data attribute in Postman
    return Employee(id: json["id"], name: json["name"],
         email: json["email"], address: json["address"],
         department: json["department"]);
  }

  /*
    Fetching Data from HTTP
    ------------------------
   */
  // 8. VERY IMPORTANT
  /*
     If you have a Array, you need to do Array JSON to List Object transformer
     List<className>
   */
  static List<Employee> employeesFromJson(dynamic json){

    // json["sheet1"] based on Sheety API(Google Sheet name)
    var searchResult = json["sheet1"];
    List<Employee> results = List.empty(growable: true);

    if (searchResult != null){

      searchResult.forEach((v)=>{
        results.add(Employee.fromJson(v))
      });
      return results;
    }
    return results;
  }

}