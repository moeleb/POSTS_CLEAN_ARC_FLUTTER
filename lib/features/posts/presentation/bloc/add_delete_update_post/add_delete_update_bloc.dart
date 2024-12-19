import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/strings/messages.dart';
import 'package:posts/features/posts/domain/usecase/create_new_post.dart';
import 'package:posts/features/posts/domain/usecase/delete_post.dart';
import 'package:posts/features/posts/domain/usecase/update_post.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_event.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_state.dart';

import '../../../../../core/error/failures.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final CreateNewPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;

  AddDeleteUpdatePostBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddDeleteUpdateStateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final failureOrDoneMessage = await addPost(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final failureOrDoneMessage = await updatePost(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final failureOrDoneMessage = await deletePost(event.postId);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdateState _eitherDoneMessageOrErrorState(
      Either<AppFailure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateState(message: message),
    );
  }

  String _mapFailureToMessage(AppFailure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return "ServerFailure";

      case const (OfflineFailure):
        return "OfflineFailure";
      default:
        return "UnExpected Error try again later";
    }
  }
}
