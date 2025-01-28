import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plusclouds/src/models/blog_model.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});
  static const String routeName = '/post-details';

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    final blog = ModalRoute.of(context)!.settings.arguments as BlogData;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/app/splash.png",
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 10),
              const Text(
                'Plusclouds',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  blog.title!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                    itemCount: blog.tags!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Chip(
                        label: Text(
                          "#${blog.tags![index]}",
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      );
                    }),
              ),
              ListTile(
                title: Text(
                  blog.body!,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Container(
                color: Colors.blue.withValues(alpha: 26),
                child: ListTile(
                  title: Text(blog.user!.fullname!),
                  trailing: Text(DateFormat.yMMMMd().format(blog.createdAt!)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
