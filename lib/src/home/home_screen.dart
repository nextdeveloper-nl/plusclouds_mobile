import 'package:flutter/material.dart';
import 'package:plusclouds/constants.dart';
import 'package:plusclouds/src/provider/app_provider.dart';
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
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ExpansionTile(
                  title: const Text(
                    'IAM',
                    style: drawerMainMenuTextStyle,
                  ),
                  children: [
                    ListTile(
                      title: const Text('Accounts'),
                      leading: const Icon(Icons.account_circle),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Users'),
                      leading: const Icon(Icons.people),
                      onTap: () {},
                    ),
                  ]),
              ExpansionTile(
                  title: const Text(
                    'CRM',
                    style: drawerMainMenuTextStyle,
                  ),
                  children: [
                    ListTile(
                      title: const Text('Accounts'),
                      leading: const Icon(Icons.account_circle),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('User'),
                      leading: const Icon(Icons.people),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Accounts Managers'),
                      leading: const Icon(Icons.manage_accounts),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Opportunities'),
                      leading: const Icon(Icons.money),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Quotes'),
                      leading: const Icon(Icons.request_quote),
                      onTap: () {},
                    ),
                  ]),
              ExpansionTile(
                  title: const Text(
                    'Marketplace',
                    style: drawerMainMenuTextStyle,
                  ),
                  children: [
                    ListTile(
                      title: const Text('Dashboard'),
                      leading: const Icon(Icons.dashboard),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Markets'),
                      leading: const Icon(Icons.shopping_cart),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Products'),
                      leading: const Icon(Icons.shopping_bag),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Product Catalogs'),
                      leading: const Icon(Icons.list),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Subscriptions'),
                      leading: const Icon(Icons.subscriptions),
                      onTap: () {},
                    ),
                  ]),
              ExpansionTile(
                  title: const Text(
                    'Support',
                    style: drawerMainMenuTextStyle,
                  ),
                  children: [
                    ListTile(
                      title: const Text('Tickets'),
                      leading: const Icon(Icons.support_agent),
                      onTap: () {},
                    ),
                  ]),
              ListTile(
                title: const Text(
                  'Partnership',
                  style: drawerMainMenuTextStyle,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).changeTheme();
                //Navigator.pushNamed(context, '/second');
              },
              child: const Text('Change Theme'),
            ),
          ),
        ],
      ),
    );
  }
}
