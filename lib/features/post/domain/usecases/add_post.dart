import 'package:dartz/dartz.dart';
import 'package:tests/features/post/domain/repos/post_repo.dart';

import '../../../../global_core/failures.dart';
import '../entities/post_entity.dart';

class AddPostUseCase{
  final PostRepo repo;

  AddPostUseCase(this.repo);

  Future<Either<Failure,Unit>> call(Post post) async{
    return await repo.addPost(post);
  }
}