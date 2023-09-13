import 'package:flutter_estudos/model/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsRepository {
  Future<List<PostModel>> getPosts() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      var jsonPosts = jsonDecode(response.body);
      return (jsonPosts as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
