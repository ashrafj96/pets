import 'package:flutter/material.dart';
import 'package:pets/account/account_page.dart';
import 'package:pets/categories/categories_page.dart';
import 'package:pets/home/cupertino_home_scaffold.dart';
import 'package:pets/home/tab_item.dart';
import 'package:pets/maps/maps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.categories;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.categories: (_) => CategoriesPage(),
      TabItem.shops: (_) => GMap(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      onSelectTab: _select,
      widgetBuilders: widgetBuilders,
    );
  }
}
