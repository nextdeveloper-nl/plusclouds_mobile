import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plusclouds/src/utils/custom_widgets/expandeble_fab.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});
  static const String routeName = '/user-details';

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Account Details"),
        ),
        floatingActionButton: ExpandableFab(
          distance: 112,
          children: [
            ActionButton(
              onPressed: () {},
              icon: const Icon(Icons.format_size),
            ),
            ActionButton(
              onPressed: () {},
              icon: const Icon(Icons.insert_photo),
            ),
            ActionButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 128),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(args['name']),
                      subtitle: Text(args['description']),
                      leading: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat().add_yMMM().format(DateTime.parse(args['created_at'])),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              color: Colors.red,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
            ),
            const Text('User Details Page'),
          ],
        ));
  }
}
