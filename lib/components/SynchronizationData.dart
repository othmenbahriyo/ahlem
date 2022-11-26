import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_application_1/data/local/models/annonce.dart';
import 'package:http/http.dart' as http;

class SyncronizationData {
  ConnectivityResult? _connectivityResult;

  static Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
 
    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
    } else {
      print('Not connected to any network');
    }
 
    
  }

  //final conn = SqfliteDatabaseHelper.instance;
  
  Future<List<AnnonceFields>> fetchdata()async{
    final dbAnnonce = await ConnectivityResult;
    List<AnnonceFields> listOfAnnonce = [];
    // try {
    //   final maps = await dbAnnonce(databaseHelper.AnnonceTable);
    //   for (var item in maps) {
    //     listOfAnnonce.add(Annonce.fromJson(item));
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }
    return listOfAnnonce;
  }

  Future saveToMysqlWith(List<Annonce> listOfAnnonce)async{
    for (var i = 0; i < listOfAnnonce.length; i++) {
      Map<String, dynamic> data =                  {
       'etat': AnnonceFields.etat,
       'localisation': AnnonceFields.localisation,
       'temps': DateTime.now().toString(),
       'details': AnnonceFields.details,
       'nombre': AnnonceFields.nombre,
       'description': AnnonceFields.description,
       'imageUrl': 'imageUrl',
       'issync': false,
       'isupdate': true,      };
      final response = await http.post(
        Uri.parse(
          "http://192.168.100.3:1337/api/annonces"),
          body: data);
      if (response.statusCode==200) {
        print("Saving Data ");
      }else{
        print(response.statusCode);
      }
    }
  }
  Future<void> update (List listOfAnnonce, isSync) async {
    if(isSync==false) {
    for (var i = 0; i < listOfAnnonce.length; i++) {
      Map<String, dynamic> data = {
       'etat': AnnonceFields.etat,
       'localisation': AnnonceFields.localisation,
       'temps': DateTime.now().toString(),
       'details': AnnonceFields.details,
       'nombre': AnnonceFields.nombre,
       'description': AnnonceFields.description,
       'imageUrl': 'imageUrl',
       'issync': false,
       'isupdate': true,
      };
      final response = await http.post(
        Uri.parse(
          "http://192.168.100.3:1337/api/annonces"),
          body: data);
      if (response.statusCode==200) {
        print("Saving Data ");
      }else{
        print(response.statusCode);
      }
    }
  }
  }
  Future<List<Annonce>> getAnnonceFromLocalDataBase(bool isSync) async {
       List<Annonce>list=[];

    if(isSync==false) {
    Map<String, String> headers = {
      'ContentType': 'apllication/json',
      'Accept': 'apllication/json',
    };
    var response = await http.get(
        Uri.parse("http://192.168.1.34:1337/api/annonces"),
        headers: headers);
    var jsonData = jsonDecode(response.body);

for(var annonce in jsonData){
  list.add(Annonce(etat: annonce["etat"], localisation: annonce["localisation"], temps: annonce["temps"], details: annonce["details"], nombre: annonce["nombre"], description: annonce["description"], imageUrl: annonce["imageUrl"]));
}

    } else {
     print("*****");
    }
    return list;
    }

}