import 'package:flutter_estudos/model/comment_model.dart';
import 'package:flutter_estudos/repositories/comments/comments_repository.dart';
import 'package:flutter_estudos/repositories/jsonplaceholder_custom_dio.dart';

class CommentsRepositoryDio implements CommentsRepository {
  @override
  Future<List<CommentsModel>> retornaComentarios(int postId) async {
    var jsonPlaceHolderCustomDio = JsonPlaceHolderCustomDio();
    var response =
        await jsonPlaceHolderCustomDio.dio.get('/posts/$postId/comments');
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CommentsModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
