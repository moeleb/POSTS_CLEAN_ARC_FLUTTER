import 'package:dartz/dartz.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<AppFailure, Unit>> call(int postId) async {
    return repository.deletePost(postId);
  }
}
