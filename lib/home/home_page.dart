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
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.categories: GlobalKey<NavigatorState>(),
    TabItem.shops: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.categories: (_) => CategoriesPage(),
      TabItem.shops: (_) => GMap(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      //pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
