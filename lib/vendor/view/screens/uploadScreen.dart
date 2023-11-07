import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_store/vendor/view/screens/upload_tab_screens/attributeTabScreen.dart';
import 'package:multi_vendor_store/vendor/view/screens/upload_tab_screens/genarelTabScreen.dart';
import 'package:multi_vendor_store/vendor/view/screens/upload_tab_screens/imageTabScreen.dart';
import 'package:multi_vendor_store/vendor/view/screens/upload_tab_screens/shippingTabScreen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          bottom: TabBar(
            tabs: [
              Tab(child: Text("Genarel"),),
              Tab(child: Text("Shiping"),),
              Tab(child: Text("Attributes"),),
              Tab(child: Text("Images"),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GenarelScreen(),
            ShippingScreen(),
            AttributeScreen(),
            ImageScreen(),
          ],
        ),
      ),
    );
  }
}
