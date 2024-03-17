import 'package:flutter/material.dart';
import 'package:tests/features/post/domain/entities/post_entity.dart';
import 'package:tests/features/post/presentation/pages/post_detail_page.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, inx) {
          return ListTile(
            leading: Text(posts[inx].id.toString()),
            title: Text(
              posts[inx].title,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              posts[inx].body,
              style: const TextStyle(fontSize: 18),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>PostDetailPage(post: posts[inx])));
            },
          );
        },
        separatorBuilder: (context, inx) {
          return const Divider(
            thickness: 1,
          );
        },
        itemCount: posts.length);
  }
}
