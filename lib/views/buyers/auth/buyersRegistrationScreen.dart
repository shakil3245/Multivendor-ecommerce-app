import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_vendor_store/views/buyers/auth/loginScreen.dart';

class BuyerRegistrationScreen extends StatefulWidget {



  @override
  State<BuyerRegistrationScreen> createState() => _BuyerRegistrationScreenState();
}

class _BuyerRegistrationScreenState extends State<BuyerRegistrationScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  File? imageFile;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? imageUrl;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  final ImagePicker picker = ImagePicker();
// picked image from gallary
  Future<void> _picImageFromGallary() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    _imageCropper(photo!.path);
    Navigator.pop(context);
  }
  // picked image from Camera
  Future<void> _picImageFromCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera );
    _imageCropper(photo!.path);
    Navigator.pop(context);
  }

  // crop image function
  Future<void> _imageCropper(filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath,maxHeight: 1080,maxWidth: 1080
    );

    if(croppedFile != null){
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
  }



  // this fucntion helps to sent data to firebase
  _submitFormFroSignUp() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if(isValid){
      if(imageFile == null){
        Fluttertoast.showToast(
            msg: "Please Select Image",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        // create user with createUserWithEmailAndPassword
        final credential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );
        // upload user image to cloude storgae
        final User? user = _auth.currentUser;
        final _uid = user!.uid;

        //this portion store data to firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child("buyerImage").child(_uid + ".jpg");
        await storageRef.putFile(imageFile!);
        imageUrl = await storageRef.getDownloadURL();

        // upload data to cloude firestore
        FirebaseFirestore.instance.collection('buyers').doc(_uid).set(
            {
              'id': _uid,
              'name': _nameController.text, // John Doe// Stokes and Sons
              'email': _emailController.text,
              'userImage': imageUrl,
              'password': _passwordController.text,
              'phoneNumber': _phoneController.text,
              'location': _addressNameController.text,
              'createdAt': Timestamp.now(),
            }

        );
        Navigator.canPop(context)? Navigator.pop(context):null;
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _phoneController.clear();
        _addressNameController.clear();


      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
      }
      setState(() {
        _signUpFormKey.currentState!.reset();
      });
       return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text("Successfully Created!")));
    }else{
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("Please fill all the Requirments!")));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _signUpFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(60)),

                        ),

                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: imageFile== null ? IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: () {
                            showDialog(context: context,
                                builder: (context)=>
                                    AlertDialog(
                                      title: Text("Select Image"),
                                      actions: [
                                        Row(
                                          children: [
                                            Icon(Icons.camera_alt_outlined,size: 25,color: Colors.deepPurpleAccent,),
                                            SizedBox(width: 3,),
                                            TextButton(onPressed: (){
                                              _picImageFromCamera();
                                            }, child: Text("Camera",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),)
                                          ],),
                                        Row(
                                          children: [
                                            Icon(Icons.image,size: 25,color: Colors.deepPurpleAccent),
                                            SizedBox(width: 3,),
                                            TextButton(onPressed: (){
                                              _picImageFromGallary();
                                            }, child: Text("Gallary",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),)
                                          ],),
                                      ],
                                    )
                            ); },):Image.file(imageFile!,fit: BoxFit.cover,),
                        )
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                      child: Text(
                        "Create Customer's Account",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                      )),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: _nameController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter Name";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Full Name',
                      labelText: ' Enter Full Name ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter Phone Number";
                      }else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Phone Number',
                      labelText: 'Enter Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _addressNameController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter Address";
                      }else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Address',
                      labelText: 'Enter Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter Email";
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
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
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter Password";
                      }else{
                        return null;
                      }
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password',
                      labelText: 'EnterPassword',
              
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: _isLoading?Center(child: CircularProgressIndicator(),): SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            onPressed: () {_submitFormFroSignUp();},
                            child: const Text(
                              "Register",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ))),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text("Already Have An Account? "),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }, child: const Text("Login"))
                  ],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
