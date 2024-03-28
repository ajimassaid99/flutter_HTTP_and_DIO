import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:restapi/core/Halper/ApiHelper.dart';
import 'package:restapi/features/items/model/items.dart';

final dio = Dio(BaseOptions(baseUrl: "http://192.168.8.194:3000"));
final apiHelper1 = ApiHelper(baseUrl: "http://192.168.8.194:3000");

Future<List<Item>> fetchItems() async {
  final response = await http.get(Uri.parse('http://192.168.8.194:3000/items'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print("jalan");
    return jsonResponse.map((data) => Item.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}

Future<void> createItems(String name) async {
    final url = Uri.parse('http://192.168.8.194:3000/items'); 
    final headers = {"Content-Type": "application/json"}; 
    final body = jsonEncode({'name': name});

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      // Jika server mengembalikan response sukses
      print("Data berhasil ditambahkan");
      
    } else {
    throw Exception('Failed to load items');
  }
  }catch (e) {
    print("Terjadi kesalahan saat mengirim data: $e");
  }

}

Future<void> createItemsDio(String name) async {
  try {
    final response = await apiHelper1.dio.post('/items',data: {"name":name});
    if (response.statusCode == 200) {
      // Jika server mengembalikan response sukses
      print("Data berhasil ditambahkan");
      
    } else {
    throw Exception('Failed to load items');
  }
  }catch (e) {
    print("Terjadi kesalahan saat mengirim data: $e");
  }

}
