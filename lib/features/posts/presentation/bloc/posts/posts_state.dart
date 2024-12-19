import 'package:posts/features/posts/domain/entities/post.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostLoadingState extends PostsState {}

class PostLoadedState extends PostsState {
  final List<Post> posts;

  PostLoadedState({required this.posts});
}

class ErrorPostsState extends PostsState {
  final String message;

  ErrorPostsState({required this.message});
}

class PostSuccessState extends PostsState {}
