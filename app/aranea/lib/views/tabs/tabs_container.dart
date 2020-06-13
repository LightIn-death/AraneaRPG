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
  int _currentIndex = 1;
  var _pages = [ProfilePage(), HomePage(), InboxPage()];
  var _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryLightColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: Text("Aranea"),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kSecondaryColor,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text("Profile")),
            BottomNavigationBarItem(
                icon: Icon(null),
                title: Text(
                  "Aranea",
                  style: TextStyle(fontSize: 25),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.sms), title: Text("Messages")),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 400), curve: Curves.linear);
            });
          }),
    );
  }
}
