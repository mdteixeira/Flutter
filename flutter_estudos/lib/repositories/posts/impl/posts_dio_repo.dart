import 'dart:convert';

import 'package:flutter_estudos/model/post_model.dart';
import 'package:flutter_estudos/repositories/posts/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsDioRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    var dio = Dio();
    var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
