import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/app_theme.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:posts/features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        theme: appTheme,
        home: const PostsPage(),
      ),
    );
  }
}
