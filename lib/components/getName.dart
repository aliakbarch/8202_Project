

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetInfo extends StatelessWidget {
  GetInfo({Key? key, required this.boatData, required this.uidCallback})
      : super(key: key);

  final Map<String, dynamic> boatData;
  final Function(String?) uidCallback;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(boatData['NamaDepan'])
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final _name = snapshot.data!['NamaDepan'];
        uidCallback(_name);
        return Text(_name);
      },
    );
  }
}