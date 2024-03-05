
import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'linked_page.dart';

class linkPage extends StatefulWidget {
  const linkPage({Key? key}) : super(key: key);

  @override
  State<linkPage> createState() => _linkPageState();
}


class _linkPageState extends State<linkPage> {

  final user = FirebaseAuth.instance.currentUser!;

  bool pressedButton = false;

  //Sign Out User
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body:

      Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text("SILAHKAN PILIH UNIT KERJA",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ) ,

          SizedBox(height: 25,),

          SizedBox(
          width: 500.0,
          height: 50.0,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) {
                          return linked(aText: 'umum',);
                        }
                    ));
              },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: pressedButton ? Colors.greenAccent : Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(child: Text('UMUM',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
              ),
            ),
          ),
          ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 500.0,
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) {
                            return linked(aText: 'ipds',);
                          }
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: pressedButton ? Colors.greenAccent : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(child: Text('IPDS',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 500.0,
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) {
                            return linked(aText: 'distribusi',);
                          }
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: pressedButton ? Colors.greenAccent : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(child: Text('DISTRIBUSI',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 500.0,
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) {
                            return linked(aText: 'sosial',);
                          }
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: pressedButton ? Colors.greenAccent : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(child: Text('SOSIAL',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 500.0,
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) {
                            return linked(aText: 'nerwilis',);
                          }
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: pressedButton ? Colors.greenAccent : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(child: Text('NERWILIS',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 500.0,
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) {
                            return linked(aText: 'produksi',);
                          }
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: pressedButton ? Colors.greenAccent : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(child: Text('PRODUKSI',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                  ),
                ),
              ),
            ),

          ]
        )
      )
    );

  }
}

