import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipadu_8202/components/my_button.dart';
import 'package:sipadu_8202/screens/pages/auth_page.dart';
import '../../components/my_textfield.dart';

class UserData extends StatefulWidget {
  UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final user = FirebaseAuth.instance.currentUser!;

  final namaDepanController = TextEditingController();

  final namaBelakangController = TextEditingController();

  final nomorTelpController = TextEditingController();

  bool isObscure = true;

  bool isObscure2 = true;

  File? file;

  var options = [
    'Pegawai',
    'Non-Pegawai',
  ];

  final List<String> genderList = ['Male','Female'];

  var currentItemSelected = "Non-Pegawai";

  var role = "Non-Pegawai";

  var select;

  createData() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc(user.uid);

    //Create Map
    Map<String, dynamic> userData = {
      "Nama Depan": namaDepanController.text,
      "Nama Belakang": namaBelakangController.text,
      "Nomor Telepon": nomorTelpController.text,
      "Gender": select,
      "Role": currentItemSelected,
    };

    //print ke firestore dan direct ke AuthPage setelahnya
    documentReference.set(userData).whenComplete(() =>
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  AuthPage(), //Ke Home Pegawai
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    Map<int, String> mappedGender = genderList.asMap();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [IconButton(onPressed: () {
          FirebaseAuth auth = FirebaseAuth.instance;
           auth.signOut().then((res) {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthPage(),
             ));
             });
           },
            icon: Icon(Icons.logout))],
        centerTitle: true,

        title: Row(
          children: [
            Text("Halo "+user.email!, textAlign: TextAlign.left)
          ],
        ),
      ),

      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 25.0),

                  //Welcome Back
                  const Text('Silahkan Melengkapi Data Terlebih Dahulu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      )
                  ),

                  SizedBox(height: 10.0),

                  //Nama Depan textfield
                  MyTextField(
                    controller: namaDepanController,
                    hintText: 'Nama Depan',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10.0),

                  //Nama Belakang textfield

                  MyTextField(
                    controller: namaBelakangController,
                    hintText: 'Nama Belakang',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10.0),

                  //Nama Belakang textfield

                  MyTextField(
                    controller: nomorTelpController,
                    hintText: 'Nomor Telepon',
                    obscureText: false,
                  ),


                  const SizedBox(height: 10.0),

                  //Buat Radio Button Jenis Kelamin

                StatefulBuilder(
                builder: (_, StateSetter setState) =>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Gender : ',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          ...mappedGender.entries.map(
                                (MapEntry<int, String> mapEntry) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio(
                                    activeColor: Colors.green,
                                    groupValue: select,
                                    value: genderList[mapEntry.key],
                                    onChanged: (value) => setState(() => select = value),
                                  ),
                                  Text(mapEntry.value),
                                ]),
                          ),
                        ],
                      )
                  ),

                  const SizedBox(height: 10.0),

                  //Memberikan Role pengguna

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Role : ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.greenAccent[900],
                        isDense: true,
                        isExpanded: false,
                        iconEnabledColor: Colors.black,
                        focusColor: Colors.white,
                        items: options.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValueSelected) {
                          setState(() {
                            currentItemSelected = newValueSelected!;
                            role = newValueSelected;
                          });
                        },
                        value: currentItemSelected,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  MyButton(onTap: createData, text: "Simpan")
                ]
              )
            )
        ),
      ),
    );
  }
}