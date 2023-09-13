import 'package:flutter_estudos/model/comment_model.dart';

abstract class CommentsRepository {
  Future<List<CommentsModel>> retornaComentarios(int postID);
}