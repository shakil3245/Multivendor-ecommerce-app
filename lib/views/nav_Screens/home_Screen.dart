import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_store/views/nav_Screens/widgets/Carosel_Slider.dart';
import 'package:multi_vendor_store/views/nav_Screens/widgets/categoryText.dart';
import 'package:multi_vendor_store/views/nav_Screens/widgets/searchInputWidgets.dart';
import 'package:multi_vendor_store/views/nav_Screens/widgets/welcomeTextWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final List<String> _categoryList = ['Book','Restaurant','Tea','Food Court','Electronic',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              welcomeWidgets(),
              SizedBox(height: 14,),
              searchWudgets(),
              SizedBox(height: 14,),
              caroselSlider(),
              categoryText(),
              Container(height: 40,
              child:Row(
                children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ActionChip(backgroundColor: Colors.orange.withOpacity(0.8),
                          onPressed: (){},
                          label: Text(_categoryList[index],style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),),
                      );
                  },
                    itemCount: _categoryList.length,
                  ),
                ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
              ],)
              ),
            ],
          ),
        ),
      )
    );
  }
}

