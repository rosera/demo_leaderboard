import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import '../model/item_model.dart';

Future<List<Item>> fetchItems() async {
  final response =
  await http.get(Uri.parse('http://localhost:8080/games/test'));

  print("Status: ${response.statusCode}");

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((item) => Item.fromJson(item)).toList();
  // }
  // else if (response.statusCode == 404){
    // return [];
  } else {
    // throw Exception('Failed to fetch items');
    return [];
  }
}
