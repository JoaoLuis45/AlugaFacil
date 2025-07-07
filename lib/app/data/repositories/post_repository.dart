import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/data/providers/post_provider.dart';

class PostRepository {
  final PostProvider postProvider;

  PostRepository(this.postProvider);

  Future<void> setPost(PostModel post) {
    return postProvider.setPost(post);
  }

  void handle(event) {
    return postProvider.handle(event);
  }
}