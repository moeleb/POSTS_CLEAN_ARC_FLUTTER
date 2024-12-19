import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_state.dart';
import 'package:posts/features/posts/presentation/pages/post_add_update_widget.dart';
import 'package:posts/features/posts/presentation/widgets/posts_page/post_list_widget.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_event.dart';
import '../widgets/posts_page/message_display_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Posts Page"),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const LoadingWidget();
          } else if (state is PostLoadedState) {
            return RefreshIndicator(
              child: PostListWidget(posts: state.posts),
              onRefresh: () => _onRefresh(context),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(
              message: state.message,
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }

  FloatingActionButton _buildFloatingBtn(context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostAddUpdate(isUpdatePost: false)));
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostEvent());
  }
}
