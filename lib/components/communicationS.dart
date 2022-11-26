/*
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/local/models/annonce.dart';

class CommunicationS extends StatefulWidget {
  const CommunicationS({
    Key? key,
  }) : super(key: key);

  @override
  State<CommunicationS> createState() => _CommunicationS();
}

class _CommunicationS extends State<CommunicationS> {

  Future<List<Annonce>> getAnnonceFromServer() async {
    if(isSync==false) {
    Map<String, String> headers = {
      'ContentType': 'apllication/json',
      'Accept': 'apllication/json',
    };
    var response = await http.get(
        Uri.parse("http://192.168.1.34:1337/api/annonces"),
        headers: headers);
    var jsonData = jsonDecode(response.body);
    data.length > 0 {
      Response response = await http.post(
        Uri.parse(
          "http://192.168.100.3:1337/api/annonces"),
          body: data);
    print(response.statusCode);
    final responseDate = jsonDecode(response.body);
    print("${response.statusCode}"); 
      Future<int> update(Annonce annonce) async {
    final db = await instance.database;

    return db.update(
      tableAnnonces,
      annonce.toJson(),
      where: '${AnnonceFields.id} = ?',
      whereArgs: [annonce.id],
    );
    for (var i = 0; i < Annonce.length; i++) {
  if (isSynct==false) {
    continue; // jump to next iteration
  }
  if (isSync==true) {
    break; // stop loop immediately
  }
  print(Annonce);
}
  }

      }else{
    }
  Future<List<Annonce>> getAnnonceFromLocalDataBase() async {
    if(isSync==true) {
    Map<String, String> headers = {
      'ContentType': 'apllication/json',
      'Accept': 'apllication/json',
    };
    var response = await http.get(
        Uri.parse("http://192.168.1.34:1337/api/annonces"),
        headers: headers);
    var jsonData = jsonDecode(response.body);
}*/
