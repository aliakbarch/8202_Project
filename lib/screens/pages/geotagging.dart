import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

import 'auth_page.dart';

class geotag extends StatefulWidget {
  const geotag({super.key});

  @override
  State<geotag> createState() => _geotagState();
}

class _geotagState extends State<geotag> {

  String locationMessage = 'Current Location of the User';

  AlertDialog leadDialog = AlertDialog(
    title: Text("Selesai"),
    content: Text("Lokasi Berhasil Dicatat"),
  );

  DateTime _now = DateTime.now();
  String formatTime = DateFormat('kk:mm:ss').format(DateTime.now());

  late String lat;

  late String long;

  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(0.3295875, 127.8584078), zoom: 10);

  Set<Marker> markers = {};

  void alertDialog() {
   QuickAlert.show(
       context: context,
       title: "Berhasil",
       text: "Sudah tercatat",
       type: QuickAlertType.success);
  }

  final user = FirebaseAuth.instance.currentUser!;

  createLocationMasuk() async {
    
    DocumentReference documentReferenceMasuk =
    FirebaseFirestore.instance.collection("users").doc(user.uid).collection("Masuk").doc("${_now.day}-${_now.month}-${_now.year}");

    //Create Map
    Map<String, dynamic> docLocation = {
      "Time": formatTime,
      "Lat": lat,
      "Long": long,
    };

    //print ke firestore dan direct ke AuthPage setelahnya
    documentReferenceMasuk.set(docLocation).whenComplete(() =>
   alertDialog());
  }

  createLocationPulang() async {
    DocumentReference documentReferencePulang =
    FirebaseFirestore.instance.collection("users").doc(user.uid).collection("Pulang").doc("${_now.day}-${_now.month}-${_now.year}");

    //Create Map
    Map<String, dynamic> docLocation = {
      "Time": formatTime,
      "Lat": lat,
      "Long": long,
    };

    //print ke firestore dan direct ke AuthPage setelahnya
    documentReferencePulang.set(docLocation).whenComplete(() =>
    alertDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Row(
          children: [
            Text("Getoagging",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14
              ),
            )
          ],
        ),
      ),

      body:

          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller){
              googleMapController = controller;
            },
          ),

      floatingActionButton: FloatingActionButton.extended(

        onPressed: () async {

        Position position = await _determinePosition();

        googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14)));
        
        markers.clear();
        
        markers.add(Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude)));

        setState(() {

        });
      },
        label: const Text("Lokasi Saat Ini"),
        icon: const Icon(Icons.location_history),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            ElevatedButton(
                onPressed: (){
              _determinePosition().then((value){
                lat = '${value.latitude}';
                long = '${value.longitude}';

                createLocationMasuk();

                //Ini dipake kalo mau nyari lat/long Part 1
                // setState(() {
                //   locationMessage = 'Latitude: $lat , Longitude: $long';
                // });
              });
            },
                child: Text('Catat Waktu Masuk',
                  style: TextStyle(fontSize: 13),)),

            ElevatedButton(
                onPressed: (){
                  _determinePosition().then((value){
                    lat = '${value.latitude}';
                    long = '${value.longitude}';

                    createLocationPulang();

                    //Ini dipake kalo mau nyari lat/long Part 1
                    // setState(() {
                    //   locationMessage = 'Latitude: $lat , Longitude: $long';
                    // });
                  });
                },
                child: Text('Catat Waktu Pulang',
                style: TextStyle(fontSize: 13),)),

            //Sambungan dari nyari Lag/Long Part 2
            // Text(locationMessage,
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(
            //       color: Colors.green,
            //       fontSize: 7
            //   ),
            // )
          ],
        ),
      ),
    );
  }
  ///Get Position
  Future<Position> _determinePosition() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('Location is Disabled');
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied){
        return Future.error("Location Permission Denied");
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error("Location Permission are Denied Permanently");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;

  }
}


