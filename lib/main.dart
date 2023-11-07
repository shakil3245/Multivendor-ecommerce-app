import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_store/vendor/view/screens/mainVendorScreen.dart';

import 'package:multi_vendor_store/views/buyers/auth/loginScreen.dart';
import 'package:multi_vendor_store/views/buyers/main_screen.dart';

import 'firebase_options.dart';
import 'views/buyers/auth/buyersRegistrationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'D-Shop',
      theme: ThemeData(
          backgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Brand-Bold'
      ),
      home: MainScreen(),
    );
  }
}
