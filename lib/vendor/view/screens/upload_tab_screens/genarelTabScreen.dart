import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenarelScreen extends StatefulWidget {
  @override
  State<GenarelScreen> createState() => _GenarelScreenState();
}

class _GenarelScreenState extends State<GenarelScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _categoryList = [];

  _getCategory() async {
    await _firestore
        .collection('Categories')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['name']);
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Product Name",
                    labelText: "Enter Product Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Product Price",
                    labelText: "Enter Product Price"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Product Quantity",
                    labelText: "Enter Product Quanitity"),
              ),
              SizedBox(
                height: 10,
              ),

              //THIS FUCNTION HELPS TO GET ALL CATEGORY LIST NAME FROM FIRESTORE
              DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Select category"),
                  items: _categoryList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (value) {}),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 4,
                maxLength: 700,
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Product Description.....",
                  labelText: "Enter Product Description",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(5000));
                      },
                      child: Text("Schedule")),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900),
                      onPressed: () {},
                      child: Text("Submit"))),
            ],
          ),
        ),
      ),
    );
  }
}
