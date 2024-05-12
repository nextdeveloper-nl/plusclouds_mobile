import 'package:flutter/material.dart';
import 'package:plusclouds/src/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SeconScreen extends StatelessWidget {
  const SeconScreen({super.key});
  static const String routeName = '/second';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<AppProvider>(context).themeMode.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).changeTheme();
                //Navigator.pushNamed(context, '/second');
              },
              child: const Text('change theme'),
            ),
          ],
        ),
      ),
    );
  }
}
