import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/local/models/annonce.dart';
import 'package:flutter_application_1/screens/views/list_hashtag_view.dart';
import 'package:http/http.dart' as http;
class DataFromAPI extends StatefulWidget {
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
 Future<List<Annonce>> getAnnonceData() async {

   Map<String,String> headers = {
     'ContentType' : 'apllication/json',
     'Accept' : 'apllication/json',
   };
    var response = await http.get(Uri.parse("http://192.168.1.103:1337/api/annonces"),headers :headers);
    var jsonData = jsonDecode(response.body);
   
    List<Annonce> annonces = [];
    print(jsonData);
    for(var u in jsonData){
      print("getting data ----------> $u");
     // Annonce = Annonce(u['title'],u['description']);
      annonces.add(Annonce(description: u['description'], etat: u['etat'], localisation: u['localisation'], nombre: u['nombre'], details: u['details'], temps: u['temps']));
      print(jsonData);
    }
   // print(Annonce.length);
    return annonces;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Annonce Data'),
        actions: [
          IconButton(onPressed: (){
            getAnnonceData();
          }, icon: Icon(Icons.refresh_rounded))
        ],

      ),
      body: RefreshIndicator(
        onRefresh: ()async {
          getAnnonceData();
      setState(() {
        
      });
        },
        child: Card(child: FutureBuilder<List<Annonce>>(
          future: getAnnonceData(),
          builder: (context, snapshot){
            if(snapshot.data == null){
              return Container(
                child: const Center(
                  child: Text('Loading'),
                ),
              );
            } else return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return ListTile(
                  subtitle: Text(snapshot.data![i].description),
                );
              }
              );
          },
        ),
        ),
      ),
          
        
      
    );
  }
}
