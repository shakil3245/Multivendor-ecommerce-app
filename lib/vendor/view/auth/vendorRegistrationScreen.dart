import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/controller.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  VendorController _vendorController = VendorController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  Uint8List? _image;
//SELECT GALLERY IMAGES
  _selectGalleryImage() async {
    Uint8List im = await _vendorController.PicStoreImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  _selectCameraImage() async {
    Uint8List im = await _vendorController.PicStoreImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  // UPLOAD VENDOR DATA TO FIREBASE
  _uploadVendorData() async{
    EasyLoading.show(status: 'PLEASE WAIT');
    if (_formkey.currentState!.validate()) {
      _vendorController.registertion(
          _nameController.text,
          _emailController.text,
          _phoneController.text,
          _locationController.text,
          _image).whenComplete((){
           EasyLoading.dismiss();
           setState(() {
             _formkey.currentState!.reset();
             _image = null;
           });
      });
    } else {

      print("Bad");
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pink,
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.deepOrange, Colors.yellow])),
                    child: Center(
                        child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                _image!,
                                fit: BoxFit.fill,
                              ))
                          : IconButton(
                              onPressed: () {
                                _selectGalleryImage();
                              },
                              icon: Icon(CupertinoIcons.photo),
                            ),
                    )),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Name";
                        } else {
                          return null;
                        }
                      },
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Bussiness Name',
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Phone Number";
                        } else {
                          return null;
                        }
                      },
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Location";
                        } else {
                          return null;
                        }
                      },
                      controller: _locationController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Location'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            onPressed: () {_uploadVendorData();},
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
