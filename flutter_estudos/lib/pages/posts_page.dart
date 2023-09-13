import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/post_model.dart';
import 'package:flutter_estudos/pages/comments_page.dart';
import 'package:flutter_estudos/repositories/posts/impl/postHttp_repo.dart';
import 'package:flutter_estudos/repositories/posts/impl/posts_dio_repo.dart';
import 'package:flutter_estudos/repositories/posts/posts_repository.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PostsRepository postsRepository;

  var posts = <PostModel>[];

  var loading = false;

  @override
  void initState() {
    super.initState();
    postsRepository = PostsDioRepository();
    carregarDados();
  }

  carregarDados() async {
    setState(() {
      loading = true;
    });
    posts = await postsRepository.getPosts();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: loading
            ? Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()),
              )
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (_, index) {
                  var post = posts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CommentsPage(postID: post.id)));
                      },
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                post.body,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
