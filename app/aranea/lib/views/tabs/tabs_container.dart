import 'package:Aranea/constants.dart';
import 'package:Aranea/views/home_page/home_page.dart';
import 'package:Aranea/views/inbox_page/inbox_page.dart';
import 'package:Aranea/views/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

class TabsContainer extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<TabsContainer> with TickerProviderStateMixin {
  var _pages = [ProfilePage(), HomePage(), InboxPage()];
  var _pageController = PageController(initialPage: 1);
  TabController _tabsController;
  int tabIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabsController = TabController(initialIndex: 1, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryLightColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: TabBar(
          controller: _tabsController,
          labelColor: kPrimaryDarkColor,
          unselectedLabelColor: Colors.white,
          indicatorColor: kPrimaryDarkColor,
          tabs: [
            Tab(
              icon: Icon(Icons.account_circle),
            ),
            Tab(
              child: Center(
                  child: Text(
                "Aranea",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
            Tab(
              icon: Icon(Icons.sms),
            ),
          ],
          onTap: (index) {
            setState(() {
              _tabsController.index = index;

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
          _tabsController.index = index;
        },
      ),
    );
  }
}
