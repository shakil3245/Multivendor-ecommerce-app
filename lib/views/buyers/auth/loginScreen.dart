import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_store/controllers/authController.dart';
import 'package:multi_vendor_store/views/buyers/auth/buyersRegistrationScreen.dart';
import 'package:multi_vendor_store/views/buyers/main_screen.dart';
import 'package:multi_vendor_store/views/nav_Screens/home_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;

  //this fucntion helps to login user
  _LoginUsers() async {
    setState(() {
      _isloading = true;
    });
    if (_globalKey.currentState!.validate()) {
      String res = await _authController.LoginUser(
          _emailController.text, _passwordController.text);
      if (res == 'success') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('something went wrong!')));
      }
    }
    else {
      setState(() {
        _isloading = false;
      });
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please filed must not be empty!")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Form(
            key: _globalKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Center(
                      child: SizedBox(
                    height: 200,
                    child: Image.asset("assets/png/userLoginImage.jpg"),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Login customer's Account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      } else {
                        return null;
                      }
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Email',
                      labelText: 'Enter Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password',
                      labelText: 'Enter Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: _isloading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange),
                              onPressed: () {
                                _LoginUsers();
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have An Account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BuyerRegistrationScreen()));
                          },
                          child: const Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
