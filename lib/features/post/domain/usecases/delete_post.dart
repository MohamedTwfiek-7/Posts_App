import 'package:dartz/dartz.dart';
import 'package:tests/features/post/domain/repos/post_repo.dart';

import '../../../../global_core/failures.dart';
import '../entities/post_entity.dart';

class DeletePostUseCase{
  final PostRepo repo;

  DeletePostUseCase(this.repo);

  Future<Either<Failure,Unit>> call(int postID) async{
    return await repo.deletePost(postID);
  }
}