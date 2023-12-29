import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sipadu_8202/screens/pages/home_mitra_page.dart';
import 'package:sipadu_8202/screens/pages/user_data_page.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRole extends StatefulWidget {
  const UserRole({super.key});

  @override
  State<UserRole> createState() => _UserRoleState();
}

class _UserRoleState extends State<UserRole> {

  final user = FirebaseAuth.instance.currentUser!;

  //Sign Out User
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
        centerTitle: true,
        title: Row(
          children: [
            Text("Halo ${user.email!}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BERHASIL MASUK SEBAGAI ${user.email!}", textAlign: TextAlign.center,),
            const SizedBox(height: 25.0),
            MaterialButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              onPressed: route,
              color: Colors.green,
              elevation: 5.0,
              height: 40,
              child: const Text(
                "OK",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('Role') == "Pegawai") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  HomePage(), //Ke Home Pegawai
            ),
          );
        }else if (documentSnapshot.get('Role') == "Non-Pegawai") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  HomeMitra(), //Ke Home Mitra dsbnya
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  UserData(), //Ke Pengisian Data Diri
          ),
        );
      }
    });
  }//
}
