import 'dart:html';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocalisationObjet extends StatelessWidget {
  
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocalisationO(),
       
     );
   }
 }
 class LocalisationO extends StatefulWidget {
  LocalisationO({
    Key? key, this.color}): super(key: key);
  final Color? color;
   @override
   _LocalisationOState createState() => _LocalisationOState();
 }
 
 class _LocalisationOState extends State<LocalisationO> {
   var locationMessage = "";
  
   void getCurrentLocation() async {
    var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator().getLastKnownPosition();
    print(lastPosition);
    var lat = position.latitude;
    var long = position.longitude;
    print("$lat , $long");
    setState(() {
      locationMessage = "latitude : $lat , longitude : $long";
    });
   }
   //Future<Position> getCurrentPosition({
  //LocationAccuracy desiredAccuracy = LocationAccuracy.best,
  //bool forceAndroidLocationManager = false,
  //Duration? timeLimit,
//})
   //Future<Position?> getLastKnownPosition({
    //bool forceAndroidLocationManager = false
   //})
   //location.changeSettings(accuracy:
   //LocationAccuracy.high.
   //interval: 10000,
   //distanceFilter: 5
   //);
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
       title: Text("Location Services"),
       ),
       body: Center(
         child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on,
            size: 46.0,
            color: Colors.blue,
            ),
            SizedBox(height: 10.0,),
            Text("Get user Location", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0,),
            Text("Position : $locationMessage"),
            ElevatedButton(
              onPressed: (){
                getCurrentLocation();
              },
              style:ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Colors.blue[800] )
              ),
              child: Text("Get Current Location", style: TextStyle(color: Colors.white,),),
              ),
          ],
         ),
       ),
       
     );
   }
 }