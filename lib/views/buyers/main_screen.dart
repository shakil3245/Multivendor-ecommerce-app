import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_store/views/nav_Screens/accountScreen.dart';
import 'package:multi_vendor_store/views/nav_Screens/cardScreen.dart';
import 'package:multi_vendor_store/views/nav_Screens/category_Screen.dart';
import 'package:multi_vendor_store/views/nav_Screens/home_Screen.dart';
import 'package:multi_vendor_store/views/nav_Screens/searchScreen.dart';
import 'package:multi_vendor_store/views/nav_Screens/shopScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override

  int _pageIndex = 0;
  List<Widget> _pages = [
    HomeScreen(),
    CategoriesScreen(),
    ShopScreen(),
    CardScreen(),
    SearchScreen(),
    AccountScreen(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black.withOpacity(0.4),
        selectedItemColor: Colors.orange,
        currentIndex: _pageIndex,
        onTap: (value){
         setState(() {
           _pageIndex = value;
         });
        },
        items:  [
          const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "HOME"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/explore.svg',width: 20,) , label: "CATEGORIES"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/shop.svg',width: 20,) , label: "SHOP"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/cart.svg',width: 20,) , label: "CARD"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/search.svg',width: 20,) , label: "SEARCH"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/account.svg',width: 20,) , label: "ACCOUNT"),
        ],
      ),
    );
  }
}
