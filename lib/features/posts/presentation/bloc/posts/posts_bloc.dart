import 'package:dartz/dartz.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/domain/usecase/get_all_posts.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';

class PostsBloc extends Bloc<PostEvents, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostEvents>((event, emit) async {
      if (event is GetAllPostEvent) {
        emit(PostLoadingState());
        final posts = await getAllPosts();
        emit(_mapFailureOrPostsToState(posts));
      } else if (event is RefreshPostEvent) {
        emit(PostLoadingState());
        final posts = await getAllPosts();
        emit(_mapFailureOrPostsToState(posts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<AppFailure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => PostLoadedState(posts: posts),
    );
  }

  String _mapFailureToMessage(AppFailure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      case EmptyCacheFailure:
        return "EmptyCacheFailure";
      case OfflineFailure:
        return "OfflineFailure";
      default:
        return "UnExpected Error try again later";
    }
  }
}
