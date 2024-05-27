import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plusclouds/src/provider/app_provider.dart';
import 'package:plusclouds/src/utils/drawer/sidebar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF252c34),
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Image.asset("assets/splash.png"),
        ),
        title: const Text(
          'Plusclouds',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: appProvider.homeBody.animate().fade(duration: const Duration(milliseconds: 500)),
    );
  }
}
