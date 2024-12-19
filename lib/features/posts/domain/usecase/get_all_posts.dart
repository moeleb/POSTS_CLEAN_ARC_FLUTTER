import 'package:dartz/dartz.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/domain/entities/post.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<AppFailure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
