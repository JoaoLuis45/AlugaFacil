import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/data/providers/post_provider.dart';

class PostRepository {
  final PostProvider postProvider;

  PostRepository(this.postProvider);

  Future<void> setPost(PostModel post) {
    return postProvider.setPost(post);
  }

  Future<void> alterStatusPost(PostModel post,status) {
    return postProvider.alterStatusPost(post,status);
  }

  void handle(event) {
    return postProvider.handle(event);
  }
}