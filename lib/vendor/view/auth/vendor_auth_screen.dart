import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../screens/landingScreens.dart';


class VendorAuthScreen extends StatefulWidget {
   VendorAuthScreen({Key? key}) : super(key: key);

  @override
  State<VendorAuthScreen> createState() => _VendorAuthScreenState();
}

class _VendorAuthScreenState extends State<VendorAuthScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context,snapshot){
            if(!snapshot.hasData){
              return SignInScreen(
                providers: [
                  EmailAuthProvider(),
                ],
              );
            }
            return LandingScreen();
        });
  }
}
