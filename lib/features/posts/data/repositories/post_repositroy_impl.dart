import 'package:dartz/dartz.dart';
import 'package:posts/core/error/exception.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/data/datasource/post_local_data_source.dart';
import 'package:posts/features/posts/data/datasource/post_remote_data_source.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:posts/features/posts/domain/entities/post.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/network/network_info.dart';

class PostRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<AppFailure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPost();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<AppFailure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<AppFailure, Unit>> deletePost(int id) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(id);
    });
  }

  @override
  Future<Either<AppFailure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<AppFailure, Unit>> _getMessage(
      Future<Unit> Function() deleteUpdateAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteUpdateAddPost;
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
