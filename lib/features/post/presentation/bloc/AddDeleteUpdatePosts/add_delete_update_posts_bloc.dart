import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tests/features/post/data/repos/post_repo_implement.dart';
import 'package:tests/features/post/domain/entities/post_entity.dart';
import 'package:tests/global_core/failures.dart';
import 'package:tests/global_core/messages.dart';

import '../../../../../global_core/falilure_messages.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_delete_update_posts_event.dart';

part 'add_delete_update_posts_state.dart';

class AddDeleteUpdatePostsBloc
    extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostsState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;

  AddDeleteUpdatePostsBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddDeleteUpdatePostsInitial()) {
    on<AddDeleteUpdatePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(
            _eitherDoneOrErrorState(failureOrDoneMessage, Add_Success_Message));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(
            _eitherDoneOrErrorState(failureOrDoneMessage, Update_Success_Message));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePost(event.postID);
        emit(
            _eitherDoneOrErrorState(failureOrDoneMessage, Delete_Success_Message));
      }
    });
  }

  AddDeleteUpdatePostsState _eitherDoneOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) =>
          ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure)),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Server_Failure_Message;
      case OfflineFailure:
        return Offline_Failure_Message;
      default:
        return 'Unexpected error, plz try again later';
    }
  }
}
