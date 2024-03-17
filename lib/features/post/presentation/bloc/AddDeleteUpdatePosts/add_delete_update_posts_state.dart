part of 'add_delete_update_posts_bloc.dart';

abstract class AddDeleteUpdatePostsState extends Equatable {
  const AddDeleteUpdatePostsState();
}

class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsState {
  @override
  List<Object> get props => [];
}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostsState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostsState{
  final String message;

  ErrorAddDeleteUpdatePostState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostsState{
  final String message;

  MessageAddDeleteUpdatePostState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}