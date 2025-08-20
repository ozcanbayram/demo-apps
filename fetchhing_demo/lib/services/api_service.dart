import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Accept": "application/json", "User-Agent": "FlutterApp/1.0"},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception("Veri çekilemedi. Hata kodu: ${response.statusCode}");
    }
  }
}
