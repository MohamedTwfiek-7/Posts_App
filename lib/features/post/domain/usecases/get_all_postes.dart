import 'package:dartz/dartz.dart';
import 'package:tests/features/post/domain/repos/post_repo.dart';

import '../../../../global_core/failures.dart';
import '../entities/post_entity.dart';

class GetAllPostsUseCase{
  final PostRepo repo;

  GetAllPostsUseCase(this.repo);

  Future<Either<Failure,List<Post>>> call() async{
    return await repo.getAllPosts();
  }
}