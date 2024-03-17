import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/features/post/presentation/bloc/AddDeleteUpdatePosts/add_delete_update_posts_bloc.dart';
import 'package:tests/features/post/presentation/pages/posts_page.dart';
import 'package:tests/global_core/widgets/loading_widget.dart';

import '../../../../global_core/widgets/snackbar.dart';
import '../../domain/entities/post_entity.dart';
import '../widgets/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
      );

  Widget _buildBody( ) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostsBloc , AddDeleteUpdatePostsState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().ShowSuccessSnackBar(message: state.message, context: context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const PostsPage()));
            } else if (state is ErrorAddDeleteUpdatePostState) {
              SnackBarMessage().ShowErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const LoadingWidget();
            }
            return FormWidget(isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
        ),
      ),
    );
  }
}
