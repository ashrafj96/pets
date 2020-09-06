import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets/home/tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold(
      {Key key,
      @required this.currentTab,
      @required this.onSelectTab,
      @required this.widgetBuilders})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.categories),
          _buildItem(TabItem.shops),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
            builder: (context) => widgetBuilders[item](context));
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.orangeAccent : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}