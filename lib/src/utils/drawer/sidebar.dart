import 'package:flutter/material.dart';
import 'package:plusclouds/constants.dart';
import 'package:plusclouds/src/provider/app_provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
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
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).iamAccountsHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Users'),
                      leading: const Icon(Icons.people),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).iamUsersHomeBody(context);
                      },
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
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).crmAccountsHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('User'),
                      leading: const Icon(Icons.people),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).crmUserHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Accounts Managers'),
                      leading: const Icon(Icons.manage_accounts),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).crmAccountsManagersHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Opportunities'),
                      leading: const Icon(Icons.money),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).crmOpportunitiesHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Quotes'),
                      leading: const Icon(Icons.request_quote),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).crmQuotesHomeBody(context);
                      },
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
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).marketplaceDashboardHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Markets'),
                      leading: const Icon(Icons.shopping_cart),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).marketplaceMarketsHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Products'),
                      leading: const Icon(Icons.shopping_bag),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).marketplaceProductsHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Product Catalogs'),
                      leading: const Icon(Icons.list),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).marketplaceProductCatalogsHomeBody(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Subscriptions'),
                      leading: const Icon(Icons.subscriptions),
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).marketplaceSubscriptionsHomeBody(context);
                      },
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
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false).supportTicketsHomeBody(context);
                      },
                    ),
                  ]),
              ListTile(
                title: const Text(
                  'Partnership',
                  style: drawerMainMenuTextStyle,
                ),
                onTap: () {
                  Provider.of<AppProvider>(context, listen: false).changeHomeBody(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Logout',
                  style: drawerMainMenuTextStyle,
                ),
                onTap: () {
                  Provider.of<AppProvider>(context, listen: false).logoutUser(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
