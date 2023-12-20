import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class linked extends StatelessWidget {

  final String aText;

  linked({
    super.key,
    required this.aText
  });

  final user = FirebaseAuth.instance.currentUser!;

  List<String> docID = [];

  Future unit() async {
    await FirebaseFirestore.instance.collection(aText).get().then(
            (snapshot) => snapshot.docs.forEach(
                (document) {
              print(document.reference);
              docID.add(document.reference.id);
            }
        )
    );
  }

  Future<String> getUri({required String unit, required String documentId}) async {
    final link = FirebaseFirestore.instance.collection(unit);
    final snapshot = await link.doc(documentId).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return data['url'];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Row(
          children: [
            Text("UNIT KERJA ${aText.toUpperCase()}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 14
              ),
            )
          ],
        ),
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Expanded(
                child: FutureBuilder(
                    future: unit(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                          itemCount: docID.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(docID[index]),
                              onTap: () async {
                                launchUrl(
                                    Uri.parse(await getUri(documentId: docID[index], unit: aText)),
                                    mode: LaunchMode.externalApplication
                                );
                              },
                            );
                          }
                      );
                    }
                )
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: const [
            Text("Link dengan tanda * menggunakan VPN",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16
              ),
            )
          ],
        ),
      ),
    );

  }
}
