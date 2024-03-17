import 'package:dartz/dartz.dart';
import 'package:tests/features/post/data/models/post_model.dart';
import 'package:tests/features/post/domain/entities/post_entity.dart';
import 'package:tests/features/post/domain/repos/post_repo.dart';
import 'package:tests/global_core/exceptions.dart';
import 'package:tests/global_core/failures.dart';
import '../../../../global_core/network/network_info.dart';
import '../data_sources/post_local_source.dart';
import '../data_sources/post_remot_source.dart';
typedef addDeleteUpdate = Future<Unit> Function();


class PostRepoImp implements PostRepo {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSourceImp localDataSource;
  final NetworkInfo networkInfo;

  PostRepoImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return right(localPosts);
      } on EmptyCashException {
        return Left(EmptyCashFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return await getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await getMessage(() => remoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await getMessage(() => remoteDataSource.updatePost(postModel));
  }


  Future<Either<Failure, Unit>> getMessage(addDeleteUpdate addDeleteUpdate) async {
    if (await networkInfo.isConnected) {
      try {
        await addDeleteUpdate();
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
