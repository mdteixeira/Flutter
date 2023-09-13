import 'package:flutter_estudos/model/post_model.dart';
import 'package:flutter_estudos/repositories/jsonplaceholder_custom_dio.dart';
import 'package:flutter_estudos/repositories/posts/posts_repository.dart';

class PostsDioRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    var jsonPHcD = JsonPlaceHolderCustomDio();
    var response = await jsonPHcD.dio.get('/posts');
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
