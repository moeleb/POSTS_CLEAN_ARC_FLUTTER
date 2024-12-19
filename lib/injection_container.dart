import 'package:posts/features/posts/data/datasource/post_local_data_source.dart';
import 'package:posts/features/posts/data/datasource/post_remote_data_source.dart';
import 'package:posts/features/posts/data/repositories/post_repositroy_impl.dart';
import 'package:posts/features/posts/domain/usecase/create_new_post.dart';
import 'package:posts/features/posts/domain/usecase/delete_post.dart';
import 'package:posts/features/posts/domain/usecase/get_all_posts.dart';
import 'package:posts/features/posts/domain/usecase/update_post.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';

import 'core/network/network_info.dart';

import 'features/posts/domain/repositories/posts_repository.dart';

import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => CreateNewPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
