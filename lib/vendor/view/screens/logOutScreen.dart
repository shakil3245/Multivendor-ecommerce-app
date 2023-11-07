import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogOutScreen extends StatelessWidget {
   LogOutScreen({Key? key}) : super(key: key);
 FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(onPressed: ()async{
        await _auth.signOut();
      }, child: Text("SignOut")),
    );
  }
}
