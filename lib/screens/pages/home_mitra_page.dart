import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/square_tile.dart';
import 'auth_page.dart';
import 'geotagging.dart';

class HomeMitra extends StatelessWidget {
  HomeMitra({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    //Sign User Out
    void signUserOut(){
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  AuthPage(), //Ke Home Mitra dsbnya
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))],
        centerTitle: true,
        title: Row(
          children: [
            Text("Halo ${user.email!}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white
              )
              ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),

                SquareTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) {
                                return const geotag();
                              }
                          ));
                    },
                    imagePath: 'lib/images/marker24x.png'
                ),
          ],
        ),
      ]),
    ));
  }
}
