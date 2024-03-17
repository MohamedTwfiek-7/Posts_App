import 'package:bloc/bloc.dart';
import 'package:tests/features/post/domain/entities/post_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:tests/features/post/presentation/bloc/posts/posts_events.dart';
import 'package:tests/features/post/presentation/bloc/posts/posts_state.dart';
import 'package:tests/global_core/failures.dart';

import '../../../../../global_core/falilure_messages.dart';
import '../../../domain/usecases/get_all_postes.dart';

class PostsBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostEvent) {
        print('=======================');
        emit(LoadingPostsState());
        final postsOrFailure = await getAllPosts(); //callable class

        postsOrFailure.fold(
          (failure) {
            emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
          },
          (posts) {
            emit(LoadedPostsState(posts: posts));
          },
        );
      }
    });
  }
  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return Server_Failure_Message;
      case EmptyCashFailure:
        return Empty_Cache_Failure_Message;
      case OfflineFailure:
        return Offline_Failure_Message;
      default:
        return 'Unexpected error, plz try again later';
    }
  }

}
