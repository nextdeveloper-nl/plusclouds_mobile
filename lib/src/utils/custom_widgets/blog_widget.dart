import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plusclouds/src/models/blog_model.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key, required this.blog});
  final BlogData blog;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/post-details', arguments: blog);
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              " ${blog.title} ${"\n"} ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text((blog.body ?? "").substring(0, blog.body != null ? (blog.body!.length >= 240 ? 240 : blog.body!.length) : 0)),
          ),
          const ListTile(
            title: Text(
              "read more...",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          ListTile(
            title: Text(blog.user!.fullname ?? "", style: const TextStyle(fontSize: 12)),
            trailing: Text(
              DateFormat.yMMMMd().format(blog.createdAt!),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
