
import 'package:sqflite/sqflite.dart';
import 'main.dart';
import 'dart:async';

class Products {
  final id;
  final String name; 
  final double price;

  Products({required this.id, required this.name , required this.price});


  Map <String, Object?> toMap(){
    return {"id":id, "name": name, "price":price };
  }

  String toString() {
    return "Products {id:$id, name: $name, price:$price }";
  }
}




