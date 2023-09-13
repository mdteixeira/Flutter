import 'package:flutter_estudos/model/post_model.dart';
import 'package:flutter_estudos/repositories/posts/posts_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsRepositoryHttp implements PostsRepository {

  @override
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
