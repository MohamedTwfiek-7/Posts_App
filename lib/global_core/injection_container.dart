import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tests/features/post/data/data_sources/post_local_source.dart';
import 'package:tests/features/post/data/data_sources/post_remot_source.dart';
import 'package:tests/features/post/data/repos/post_repo_implement.dart';
import 'package:tests/features/post/domain/repos/post_repo.dart';
import 'package:tests/features/post/domain/usecases/add_post.dart';
import 'package:tests/features/post/domain/usecases/delete_post.dart';
import 'package:tests/features/post/domain/usecases/get_all_postes.dart';
import 'package:tests/features/post/domain/usecases/update_post.dart';
import 'package:tests/features/post/presentation/bloc/AddDeleteUpdatePosts/add_delete_update_posts_bloc.dart';
import 'package:tests/features/post/presentation/bloc/posts/posts_block.dart';
import 'package:tests/global_core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async{
  ///features posts

  //Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostsBloc(addPost: sl(), updatePost: sl(), deletePost: sl()));

  //use-cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  //repos
  sl.registerLazySingleton<PostRepo>(() => PostRepoImp(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //data sources
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton(() => PostLocalDataSourceImp(sharedPreferences: sl()));

  /// core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(connectionChecker: sl()));
  /// external
  final sp = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sp);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());


}