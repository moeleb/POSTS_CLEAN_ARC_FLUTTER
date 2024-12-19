// repo is only abstract class for implemantatio
import 'package:dartz/dartz.dart';
import 'package:posts/core/error/failures.dart';

import 'package:posts/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<AppFailure, List<Post>>> getAllPosts();

  Future<Either<AppFailure, Unit>> deletePost(int id);

  Future<Either<AppFailure, Unit>> updatePost(Post post);

  Future<Either<AppFailure, Unit>> addPost(Post post);
}
