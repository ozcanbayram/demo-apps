import 'package:fetchhing_demo/models/post_model.dart';
import 'package:flutter/material.dart';

class CustomPostCard extends StatelessWidget {
  const CustomPostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(
          post.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Icon(Icons.chevron_right_outlined),
        onTap: () {},
      ),
    );
  }
}
