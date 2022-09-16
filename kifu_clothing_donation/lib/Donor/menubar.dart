import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kifu_clothing_donation/Donor/Menu/addclothers.dart';
import 'package:kifu_clothing_donation/Donor/Menu/homescreen.dart';
import 'package:kifu_clothing_donation/Donor/Menu/profilescreen.dart';
import 'package:kifu_clothing_donation/constants.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
class menubar_donor extends StatefulWidget {
  const menubar_donor({Key? key}) : super(key: key);

  @override
  _menubar_donorState createState() => _menubar_donorState();
}

class _menubar_donorState extends State<menubar_donor> {

  int _pageIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _screens =
  [
    homescree_donor(), profile_donor()
  ];
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_pageIndex != 0) {
            _setPage(0);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          floatingActionButton: FloatingActionButton(
            onPressed: (){

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>addclothes()));
            },

            child: Icon(Icons.add),

          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: primaryColor,

            showUnselectedLabels: true,
            currentIndex: _pageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _barItem(Icons.home, "Home", 0),
              _barItem(Icons.perm_identity, "Profile", 1),

            ],
            onTap: (int index) {
              _setPage(index);
            },
          ),

          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _screens[index];
            },
          ),

        ));
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none, children: [
        Icon(icon),
      ],
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
