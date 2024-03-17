import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/features/post/presentation/bloc/AddDeleteUpdatePosts/add_delete_update_posts_bloc.dart';
import 'package:tests/features/post/presentation/pages/post_add_update_page.dart';
import 'package:tests/features/post/presentation/pages/posts_page.dart';
import 'package:tests/global_core/widgets/loading_widget.dart';
import 'package:tests/global_core/widgets/snackbar.dart';

import '../../../domain/entities/post_entity.dart';
import 'delete_dialog_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(post.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(
            height: 50,
          ),
          Text(post.body,
              style: const TextStyle(
                fontSize: 16,
              )),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostAddUpdatePage(
                        isUpdatePost: true,
                        post: post,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                onPressed: ()=> deleteDialog(context),
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.white,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostsBloc,
              AddDeleteUpdatePostsState>(
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: post.id!,);
            },
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().ShowSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                SnackBarMessage().ShowErrorSnackBar(
                    message: state.message, context: context);
              }
            },
          );
        });
  }
}
