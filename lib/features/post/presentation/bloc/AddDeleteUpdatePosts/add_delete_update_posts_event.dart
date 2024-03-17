part of 'add_delete_update_posts_bloc.dart';

abstract class AddDeleteUpdatePostsEvent extends Equatable {
  const AddDeleteUpdatePostsEvent();
}


class AddPostEvent extends AddDeleteUpdatePostsEvent{
  final Post post;

  AddPostEvent({required this.post});

  @override
  // TODO: implement props
  List<Object?> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdatePostsEvent{
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  // TODO: implement props
  List<Object?> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdatePostsEvent{
  final int postID;

  DeletePostEvent({required this.postID});

  @override
  // TODO: implement props
  List<Object?> get props => [postID];
}