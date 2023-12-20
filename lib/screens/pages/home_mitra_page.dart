import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeMitra extends StatelessWidget {
  HomeMitra({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  //Sign Out User
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))],
        centerTitle: true,
        title: Row(
          children: [
            Text("Halo ${user.email!}", textAlign: TextAlign.left)
          ],
        ),
      ),
      body: Center(
        child: Text("BERHASIL MASUK SEBAGAI MITRA ${user.email!}"),
      ),
    );
  }
}
