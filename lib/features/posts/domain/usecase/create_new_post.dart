import 'package:dartz/dartz.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/domain/entities/post.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

class CreateNewPostUseCase {
  final PostsRepository repository;

  CreateNewPostUseCase(this.repository);

  Future<Either<AppFailure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
