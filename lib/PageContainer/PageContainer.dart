import 'package:doit/Dashboard/DashboardPage.dart';
import 'package:doit/FindFriends/FindFriendsPage.dart';
import 'package:flutter/material.dart';
import 'package:doit/Settings/SettingsPage.dart';

class PageContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageContainer();
}

class _PageContainer extends State<PageContainer> {
  int currentTabIndex = 1;
  List<Widget> tabs = [SettingsPage(), DashboardPage(),  FindFriendsPage()];
  List<String> tabsTitle = ["Settings", "Dashboard", "Find Friends"];

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: tabs[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: onTapped,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_people),
                label: 'Find Friends'
            )
          ],
        )
    );
  }
}
