import 'package:Aranea/constants.dart';
import 'package:Aranea/views/home_page/home_page.dart';
import 'package:Aranea/views/inbox_page/inbox_page.dart';
import 'package:Aranea/views/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

class TabsContainer extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<TabsContainer> {
  var _pages = [ProfilePage(), HomePage(), InboxPage()];
  var _pageController = PageController(initialPage: 1);
  int tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    tabIndex = DefaultTabController.of(context).index;

    return Scaffold(
      backgroundColor: kSecondaryLightColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.account_circle), text: "Profile"),
            Tab(
              child: Center(child: Text("Aranea")),
            ),
            Tab(icon: Icon(Icons.sms), text: "Messages"),
          ],
          onTap: (index) {
            setState(() {
              tabIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 400), curve: Curves.linear);
            });
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            tabIndex = index;
          });
        },
      ),
    );
  }
}
