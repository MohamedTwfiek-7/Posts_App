import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/features/post/presentation/bloc/AddDeleteUpdatePosts/add_delete_update_posts_bloc.dart';
import 'package:tests/features/post/presentation/widgets/text_form_feild_widget.dart';

import '../../domain/entities/post_entity.dart';
import 'form_submit_btn.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
              name: 'Title', controller: _titleController, multiLines: false),
          TextFormFieldWidget(
              name: 'Body', controller: _bodyController, multiLines: true),
          FormSubmitBtn(isUpdatePost: widget.isUpdatePost , onPressed: validateFormThenUpdateOrAddPost),

        ],
      ),
    );
  }


  void validateFormThenUpdateOrAddPost() {
    final isValed = _formKey.currentState!.validate();
    final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text);

    if (isValed) {
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
