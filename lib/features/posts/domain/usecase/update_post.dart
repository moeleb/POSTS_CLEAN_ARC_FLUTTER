import 'package:dartz/dartz.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/domain/entities/post.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

class UpdatePostUseCase {
  final PostsRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<AppFailure, Unit>> call(Post post) async {
    return repository.updatePost(post);
  }
}
