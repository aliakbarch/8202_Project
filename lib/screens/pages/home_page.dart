import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipadu_8202/screens/pages/link_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/square_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  final websiteuri = Uri.parse('http://www.linkedin.com/in/ali-championa');

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
            Text("Halo ${user.email!}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 15
                ),
            )
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
                                return const linkPage();
                              }
                          ));
                    },
                    imagePath: 'lib/images/star24x.png',
                ),

                const SizedBox(width: 25,),

                SquareTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) {
                                return const linkPage();
                              }
                          ));
                    },
                    imagePath: 'lib/images/marker24x.png'
                ),

                const SizedBox(width: 25,),

                SquareTile(
                    onTap: () {
                      launchUrl(
                        websiteuri,
                        mode: LaunchMode.externalApplication
                      );
                    },
                    imagePath: 'lib/images/linkedin24x.png'
                ),


              ],
            ),


          ],
        ),
      ),
    );
  }
}
