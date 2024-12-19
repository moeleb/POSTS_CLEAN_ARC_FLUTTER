import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/widgets/loading_widget.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_state.dart';
import 'package:posts/features/posts/presentation/pages/posts_page.dart';

import '../../../../core/util/snackbar.dart';
import '../../domain/entities/post.dart';

class PostAddUpdate extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdate({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
    );
  }

  _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdateState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdateState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const PostsPage()),
                  (predicate) => false);
            } else if (state is ErrorAddDeleteUpdateState) {
              SnackBarMessage().showFailureSnackBar(
                  message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdateState) {
              return LoadingWidget();
            }
            return FormWidget(
              isUpdatePost: isUpdatePost,
              post: isUpdatePost ? post : null,
            );
          },
        ),
      ),
    );
  }
}
