import 'package:equatable/equatable.dart';

import '../../../domain/entities/post_entity.dart';

abstract class PostState extends Equatable{
  const PostState();

  @override
  List<Object> get prop => [];
}

class PostsInitial extends PostState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class LoadingPostsState extends PostState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class LoadedPostsState extends PostState{
  final List<Post> posts;

  LoadedPostsState({required this.posts});

  @override
  // TODO: implement props
  List<Object?> get props => [posts];

}

class ErrorPostsState extends PostState{
  final String message;

  const ErrorPostsState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}