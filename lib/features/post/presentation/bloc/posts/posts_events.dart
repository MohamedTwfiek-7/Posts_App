//part at 'posts_block.dart';

import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable{
  const PostEvent();

  @override
  List<Object> get prop => [];
}

class GetAllPostsEvent extends PostEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class RefreshPostEvent extends PostEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}