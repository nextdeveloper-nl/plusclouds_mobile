import 'package:flutter/material.dart';
import 'package:plusclouds/api.dart';
import 'package:plusclouds/constants.dart';
import 'package:plusclouds/src/utils/custom_widgets/blog_widget.dart';

class ScreenBlog extends StatefulWidget {
  const ScreenBlog({super.key});
  static const String routeName = '/blog-details';

  @override
  State<ScreenBlog> createState() => _ScreenBlogState();
}

class _ScreenBlogState extends State<ScreenBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: API().getBlogPosts([], true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
              itemBuilder: (context, index) {
                return BlogWidget(blog: snapshot.data![index]);
              },
            );
          } else {
            return Center(
              child: apiFailAnimation,
            );
          }
        },
      ),
    );
  }
}
