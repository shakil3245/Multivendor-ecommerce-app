import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class caroselSlider extends StatefulWidget {

  @override
  State<caroselSlider> createState() => _caroselSliderState();
}

class _caroselSliderState extends State<caroselSlider> {
  final ValueNotifier<int> _carrentindex = ValueNotifier(0);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // getBanners() async{
  //   return  _firestore.collection('Banners').doc().get().then((QuerySnapshot querySnapshot ){
  //
  //   });
  // }


  // List<String> _carouselImages = [];
  // var _dotPosition = 0;
  // List _products = [];
  //
  //
  // fetchCarouselImages() async {
  //   QuerySnapshot qn =
  //   await _firestore.collection('Bannners').get();
  //   setState(() {
  //     for (int i = 0; i < qn.docs.length; i++) {
  //       _carouselImages.add(
  //         qn.docs[i]["image"],
  //       );
  //       print(qn.docs[i]["img-path"]);
  //     }
  //   });
  //
  //   return qn.docs;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchCarouselImages();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index,_){
              _carrentindex.value = index;
            },
            height:160,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.ease,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
          ),
          items: [1,2,3,4,5].map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("banner"),
                  );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ValueListenableBuilder(
              valueListenable: _carrentindex,
              builder: (context,currentValue,_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(int i=0;i<4;i++)
                      Padding(
                          padding: const EdgeInsets.all(4),
                          child:Container(
                            height: 11,
                            width: 11,
                            decoration: BoxDecoration(
                              color: currentValue == i? Colors.black: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                      ),

                  ],);
              }
          ),
        ),
      ],
    );
  }
}