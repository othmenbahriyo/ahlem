import 'dart:async';
import 'dart:convert';

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/declarer_objet.dart';
import 'package:flutter_application_1/data/local/dao/annonce_doa/annonce_dao.dart';
import 'package:flutter_application_1/data/local/models/annonce.dart';
import 'package:flutter_application_1/data/local/models/beacon_sensor.dart';
import 'package:flutter_application_1/screens/home/widget.dart';
import 'package:geolocator/geolocator.dart';
import'package:geolocator/geolocator.dart'as geo;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';

import '../../utils/beacon/bluetooth_ble.dart';
import '../../utils/notification/notification_service.dart';



class HomeScreen extends StatefulWidget {
  final String? etat;
  final String? localisation;
  final String? temps;
  final String? details;
  final String? nombre;
  final String? description;
  final String? imageUrl; 

  const HomeScreen({
    Key? key,
     this.etat,
     this.localisation,
     this.temps,
     this.details,
     this.nombre,
     this.description,
     this.imageUrl,

  }) : super(key: key);
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _bluetoothBlePlugin = BluetoothBle();

Future<void> getBeacon() async {
  String result;
  try {
    result = await _bluetoothBlePlugin.getBeacon() ?? 'Unknown beacon';

    print("--------$result-------");
    BeaconSensor beaconSensor = beaconSensorFromJson(result);
    getCurrentLocation();
  } on PlatformException {
    result = 'Failed to get beacon.';
  }
}
void getCurrentLocation() async {
  var locationMessage = "";
  var position = await Geolocator().getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
  var lastPosition = await Geolocator().getLastKnownPosition();
  print(lastPosition);
  var lat = position.latitude;
  var long = position.longitude;
  print("$lat , $long");

  locationMessage = "latitude : $lat , longitude : $long";


  NotificationService().showNotification(1, "Beacon", "$locationMessage", 1);




}




class _HomeScreenState extends State<HomeScreen> {

  Future<List<Annonce>> getAnnonceData() async {
    Map<String, String> headers = {
      'ContentType': 'apllication/json',
      'Accept': 'apllication/json',
    };
    var response = await http.get(
        Uri.parse("http://192.168.1.34:1337/api/annonces"),
        headers: headers);
    var jsonData = jsonDecode(response.body);

    List<Annonce> annonces = [];
    

    for (var u in jsonData["data"]) {
      print("getting data ----------> $u");
      // Annonce = Annonce(u['title'],u['description']);
      annonces.add(Annonce(
          description: u["attributes"]['description'],
          etat: u["attributes"]['etat'] ?? "",
          localisation: u["attributes"]['localisation'] ?? "",
          nombre: u["attributes"]['nombre'] ?? "",
          details: u["attributes"]['details'] ?? "",
          temps: u["attributes"]['temps'] ?? ""));
    }
    print(annonces.length);
    return annonces;
  }
  
  
  TaskDatabaseHelper taskDatabaseHelper = TaskDatabaseHelper();
  List listOfAnnonce = [];


  void getFromLocalDataBase() async {
    var res = await taskDatabaseHelper.getALLAnnonce();
    print('ffffffffffffffffffff${ res}');
    setState(() {
      listOfAnnonce = res;
    });

  }


  late final PageController _pageController;

  final int _currentIndex = 1;
  @override
  void initState() {
    super.initState();
    getFromLocalDataBase();
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

@override
    Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Color(0xFF6F35A5),
        actions: [
          IconButton(icon:Icon(Icons.refresh), onPressed: (){
            Location().requestService().then((value){
              if(value){
                BluetoothEnable.enableBluetooth.then((result) async {
                  if(result=="true"){
                    getBeacon();
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('You should open your bluetooth !'),
                      backgroundColor: Colors.red,
                    ));
                  }
                });
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('You should open your position !'),
                  backgroundColor: Colors.red,
                ));
              }
            });

          },),
        ],
               ),
      
        body: Column(
          children: [


            Center(
              child:
                listOfAnnonce.isEmpty
                ?SizedBox(
                    height: MediaQuery.of(context).size.height *.8 ,
                    child
                    : Center(child: Lottie.asset('assets/97434-no-data-available.json')))
                :ListView.builder(
                itemCount: listOfAnnonce.length,
                itemBuilder: (context,index){
                  return  Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(listOfAnnonce[index]['localisation']),
                      subtitle: Text(listOfAnnonce[index]['etat'].toString()),
                      trailing: SizedBox(
                        width: 110,
                        child: Row(
                          children:  [
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                mydialog(context,
                                    title: "Suppression",
                                    cont: "Voulez-vous supprimer " ,
                                    ok: () async {
                                  TaskDatabaseHelper taskDatabaseHelper = TaskDatabaseHelper();
                                  print("***************${listOfAnnonce[index]['id']}");

                                  var delete =await taskDatabaseHelper.delete(listOfAnnonce[index]['id']);
                                  print("aaaaaa ${delete} aaaaaa");
                                  if (delete != true) {
                                    Navigator.of(context, rootNavigator: true).pop();
                                    getFromLocalDataBase();
                                    setState(() {

                                    });
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon:const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                print(listOfAnnonce[index]);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeclarerObjetScreen(description:listOfAnnonce[index]['description'],
                            details:listOfAnnonce[index]['details'], localisation: listOfAnnonce[index]['localisation'], etat: listOfAnnonce[index]['etat'], temps: listOfAnnonce[index]['temps'], nombre: listOfAnnonce[index]['nombre'],imageUrl: listOfAnnonce[index]['imageUrl'],)));

                            }

                            )

                          ],
                        ),
                      ),
                    ),
                  );
                }),),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF6F35A5),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeclarerObjetScreen(description:"" ,
                        details:"", localisation: "", etat: "", temps: "", nombre: "", imageUrl: "",),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      )
    );
    
  }
}
