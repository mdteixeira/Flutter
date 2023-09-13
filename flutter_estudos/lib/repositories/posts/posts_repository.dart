import 'package:flutter_estudos/model/post_model.dart';

abstract class PostsRepository {
  Future<List<PostModel>> getPosts();
}
