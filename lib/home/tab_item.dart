import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { categories, shops, account }

class TabItemData {
  final String title;
  final IconData icon;

  const TabItemData({@required this.title, @required this.icon});

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.categories: TabItemData(title: 'Categories', icon: Icons.category),
    TabItem.shops: TabItemData(title: 'Shops', icon: Icons.shopping_basket),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}
