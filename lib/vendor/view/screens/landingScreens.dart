import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/verndorModel.dart';
import '../auth/vendorRegistrationScreen.dart';
import 'mainVendorScreen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //THERE USE COLLECTION REFERENCE BECAUSE WE NEED TO GET OUR ONE MAN DATA.
  //NOT TO TOO MANY PEOPLES DATA SO ITS NOT QUERY SNAPSHOT, IT IS DOCUMENT SNAPSHOT
  final CollectionReference _vendorStream = FirebaseFirestore.instance.collection('vendors');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<DocumentSnapshot>(
        stream: _vendorStream.doc(_auth.currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if(!snapshot.data!.exists){
            return const VendorRegistrationScreen();
          }
         VendorUserModel vendorUserModel = VendorUserModel.fromJson(snapshot.data!.data()! as Map<String,dynamic>);

          if(vendorUserModel.approved == true){
            return  MainVendorScreen();
          }
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(vendorUserModel.storeImage.toString(),width: 90, fit: BoxFit.cover,),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(vendorUserModel.bussinessName.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              const Text("Your application has been sent to shop admin \n Admin will get back to you soon!",textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
              TextButton(onPressed: ()async{
                _auth.signOut();
              }, child: const Text("SignOut!",style: TextStyle(color: Colors.orange),)),
            ],
          ));
        },
      ),
    );
  }
}
