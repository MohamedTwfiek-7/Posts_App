import 'package:flutter/material.dart';

import '../../domain/entities/post_entity.dart';
import '../widgets/post_datail_page_widgets/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildbody(),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Post Detail'),);
  _buildbody(){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}
