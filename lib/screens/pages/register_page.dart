import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipadu_8202/components/my_button.dart';
import 'package:sipadu_8202/components/my_textfield.dart';
import 'package:sipadu_8202/components/square_tile.dart';
import 'package:sipadu_8202/screens/services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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

  //Sign up User
  signUpUser() async{

    //Loading
    showDialog(context: context,
        builder: (context){
          return const Center(
              child: CircularProgressIndicator());
        }
    );

    //Cek password = confirm password
    if (passwordController.text != confirmPasswordController.text){
      Navigator.pop(context);
      showErrorMessage("Password Berbeda");
      return;
    }

    //Proses Sign Up
    try {
      //Selesai Loading
      Navigator.pop(context);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      final user = FirebaseAuth.instance.currentUser!;
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("users").doc(user.uid);

      //Create Map
      Map<String, dynamic> userData = {
        "Email": emailController.text,
        "Password": passwordController.text,
        "Nama Depan": namaDepanController.text,
        "Nama Belakang": namaBelakangController.text,
        "Nomor Telepon": nomorTelpController.text,
        "Gender": select,
        "Role": currentItemSelected,
      };

      //print ke firestore dan direct ke AuthPage setelahnya
      documentReference.set(userData);


      //if Error occured
    } on FirebaseAuthException catch (e) {
      //Selesai Loading
      showErrorMessage(e.code);
    }
  }

  //Error Email
  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
            title: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.green),
                )
            )
        );
      },
    );
  }


  @override
  Widget build(BuildContext context){

    Map<int, String> mappedGender = genderList.asMap();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25.0),

                  //Logo
                  const Icon(
                    Icons.lock,
                    size: 50,
                  ),

                  const SizedBox(height: 25.0),

                  //Welcome Back
                  const Text('Silahkan Daftar Terlebih Dahulu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      )
                  ),

                  //emai textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10.0),

                  //Password textfield

                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10.0),

                  //Confirm Password textfield

                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  //Peralihan Data
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
                  //Akhir peralihan data

                  const SizedBox(height: 10),

                  //sign Up button
                  MyButton(
                    text: 'Sign Up',
                    onTap: signUpUser,
                  ),

                  const SizedBox(height: 25),

                  //sudah punya akun
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah Punya Akun?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login Disini',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )

                ],),
            ),
          )

      ),
    );
  }
}

