import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/comment_model.dart';
import 'package:flutter_estudos/repositories/comments/commentsDio_repo.dart';
import 'package:flutter_estudos/repositories/comments/comments_repository.dart';

class CommentsPage extends StatefulWidget {
  final int postID;
  const CommentsPage({super.key, required this.postID});

  @override
  State<CommentsPage> createState() => CommentsPageState();
}

class CommentsPageState extends State<CommentsPage> {
  late CommentsRepository commentsRepository;
  var comments = <CommentsModel>[];
  var loading = false;

  @override
  void initState() {
    super.initState();
    commentsRepository = CommentsRepositoryDio();
    carregarDados();
  }

  carregarDados() async {
    setState(() {
      loading = true;
    });
    comments = await commentsRepository.retornaComentarios(widget.postID);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Comentários : ${widget.postID}'),
        ),
        body: loading
            ? Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (_, int index) {
                      var comment = comments[index];

                      return Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    comment.name.substring(0, 10),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(comment.email),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(comment.body),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
