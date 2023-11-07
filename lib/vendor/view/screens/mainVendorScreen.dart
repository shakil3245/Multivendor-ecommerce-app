import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_store/vendor/view/screens/earningScreen.dart';
import 'package:multi_vendor_store/vendor/view/screens/logOutScreen.dart';
import 'package:multi_vendor_store/vendor/view/screens/uploadScreen.dart';

import 'editProfileScreen.dart';

class MainVendorScreen extends StatefulWidget {
   MainVendorScreen({Key? key}) : super(key: key);

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;
  List<Widget> _pages = [
    EarningScreen(),
    UploadScreen(),
    EditProfileScreen(),
    LogOutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,
        currentIndex: _pageIndex,
        onTap: (val){
          setState(() {
            _pageIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.money_dollar,),label: "EARNINGS"),
          BottomNavigationBarItem(icon: Icon(Icons.upload),label: "UPLOAD"),
          BottomNavigationBarItem(icon: Icon(Icons.edit),label: "EDIT"),
          BottomNavigationBarItem(icon: Icon(Icons.logout,),label: "LOGOUT"),
        ],
      ),
    );
  }
}
