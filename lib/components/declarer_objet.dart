import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/local/dao/annonce_doa/annonce_dao.dart';
import 'package:flutter_application_1/data/local/models/annonce.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DeclarerObjetScreen extends StatefulWidget {
  final String etat;
  final String localisation;
  final String temps;
  final String details;
  final String nombre;
  final String description;
  final String imageUrl;

  const DeclarerObjetScreen({
    Key? key,
    required this.etat,
    required this.localisation,
    required this.temps,
    required this.details,
    required this.nombre,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<DeclarerObjetScreen> createState() => _DeclarerObjetScreenState();
}

class _DeclarerObjetScreenState extends State<DeclarerObjetScreen> {
  TextEditingController localisation = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController decrire = TextEditingController();
  TaskDatabaseHelper taskDatabaseHelper = TaskDatabaseHelper();
  void getAnnonceFromLocalDataBase() async {
    var res = await taskDatabaseHelper.getALLAnnonce();
    print('lisssssssssssssssst$res');
  }
  void updateToLocalDataBase() async {
    var res = await taskDatabaseHelper.update({
      'etat': "$perdu",
      'localisation': localisation.text,
      'temps': DateTime.now().toString(),
      'details': details.text,
      'nombre': nombre.text,
      'description': decrire.text,
      'imageUrl': 'imageUrl',
      'issync': false,
      'isupdate': true,
    }, 10);
  }
  Future getImage(ImageSource source) async {
    try {
      final newImage = await ImagePicker().pickImage(source: source);
      if (newImage == null) {
        print("image nullllll");
      } else {
        final imageTemporary = File(newImage.path);
        print(" image found ---------> $imageTemporary");
        setState(() {
          image = imageTemporary;
          hasImage = true;
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  creeAnnonce() async {
    print(perdu);
    print(localisation);
    print(date);
    print(details);
    print(nombre);
    print(decrire);

    var data = {
      "etat": perdu,
      "localisation": localisation.text,
      "temps": "${date}",
      "details": details.text,
      "nombre": nombre.text,
      "description": decrire.text,
    };
    Annonce newAnnonce = Annonce(
        etat: (perdu == true) ? Etat.Perdu : Etat.Trouve,
        localisation: localisation.text,
        temps: date,
        details: details.text,
        nombre: int.parse(nombre.text),
        description: decrire.text);

    // var jsonResponse = null;
    Response response = await http.post(
        Uri.parse("http://192.168.100.3:1337/api/annonces"),
        body: data);
    print(response.statusCode);
    final responseDate = jsonDecode(response.body);
    print("${response.statusCode}");
  }

  Widget imagePickerIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Choisir un source"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                getImage(ImageSource.gallery)
                                    .then((value) => Navigator.pop(context));
                              },
                              icon: const Icon(Icons.collections)),
                          IconButton(
                              onPressed: () {
                                getImage(ImageSource.camera)
                                    .then((value) => Navigator.pop(context));
                              },
                              icon: const Icon(Icons.photo_camera)),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child:  Align(
        alignment: Alignment.center,
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1
            )
          ),
          child:  Center(
            child: Icon(Icons.camera)
          ),
        ),
      ),
    );
  }


  bool hasImage = false;
  File? image;
  bool perdu = false;
  DateTime date = DateTime.now();
  TextEditingController datee = TextEditingController();
  bool isupdate = true;
  var SelectedDate;

  int step = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnnonceFromLocalDataBase();

    details.text = widget.details;
    decrire.text = widget.description;
    nombre.text = widget.nombre;
    localisation.text = widget.localisation;
    datee.text =  DateFormat("dd MMMM yyyy").format(DateTime.now());


  }

  @override
  Widget build(BuildContext context)  {
    details.text = widget.details;
    decrire.text = widget.description;
    nombre.text = widget.nombre;
    localisation.text = widget.localisation;
    SelectedDate = DateTime.now();
   // Image.file(image!);

    getAnnonceFromLocalDataBase();
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          if( step == 0){
            Navigator.of(context).pop();
          } else {
            step = 0;

          }
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Déclarer un objet"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF6F35A5),
        ),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Step ${step + 1} / 2',style:const TextStyle(color: Colors.black,fontSize: 17),),
                  Slider(
                    inactiveColor: const Color(0xff7BBF0A).withOpacity(.3),
                    thumbColor: Colors.transparent,
                    activeColor:  Colors.deepPurple,

                    min: 0,
                    max: 2,
                    value: step + 1 * 1.0,
                    onChanged: (double value) {},
                  ),
                  IndexedStack(
                    index: step,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.65,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  perdu = false;
                                  step = 1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width *.9,
                                height: MediaQuery.of(context).size.height * 0.20,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.all(5),
                                decoration:const BoxDecoration(
                                    color: Color(0xffEFF3DC),
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:const  [
                                     Icon(CupertinoIcons.app_badge,color: Color(0xff3C3C3C),size: 50,),
                                     SizedBox(width: 20,),
                                    Text('Trouvé',style: TextStyle(color:const Color(0xff3C3C3C),fontSize: 26,fontWeight: FontWeight.w700),),


                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  perdu = true;
                                  step = 1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width *.9,
                                height: MediaQuery.of(context).size.height * 0.20,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.all(5),
                                decoration:const BoxDecoration(
                                    color: Color(0xffEFF3DC),
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:const [
                                     Icon(CupertinoIcons.loop,color: Color(0xff3C3C3C),size: 50,),
                                    SizedBox(width: 20,),
                                    Text('Perdu',style: TextStyle(color:const Color(0xff3C3C3C),fontSize: 26,fontWeight: FontWeight.w700),),


                                  ],
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            const Text('Localisation votre objet:',style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: localisation,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      width: 1
                                    )
                                ),
                                hintStyle: TextStyle(fontSize: 13),
                                hintText: 'Saisissez l\'adresse de la perte/trouvaile',
                              ),
                            ),
                            const SizedBox(height: 15,),
                            const Text('Date/Heure:',style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
                              child: TextFormField(
                                readOnly: true,
                                controller: datee,
                                onTap: (){
                                  showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: DateTime(DateTime.now().year),
                                      lastDate: DateTime.now())
                                      .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        date = value;
                                        datee.text = DateFormat("dd MMMM yyyy").format(date);
                                      });
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          width: 1
                                      )
                                  ),
                                  labelStyle: TextStyle(fontSize: 13),

                                ),
                              )



                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text('Décrivez votre objet:',style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 25.0),
                            const Text('Détail:',style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: details,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 1
                                    )
                                ),
                                hintStyle: TextStyle(fontSize: 13),
                                hintText: 'Détail',
                              ),
                            ),
                            const SizedBox(height: 15,),
                            const Text('Nombre:',style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: nombre,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 1
                                    )
                                ),
                                hintStyle: TextStyle(fontSize: 13),
                                hintText: 'Nombre',
                              ),
                            ),
                            const SizedBox(height: 15,),
                            const Text('Décrire:',style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: decrire,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 1
                                    )
                                ),
                                hintStyle: TextStyle(fontSize: 13),
                                hintText: 'Décrire',
                              ),
                            ),
                            const SizedBox(height: 15,),
                            const Text('Mettez une photo:',style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10.0),
                            if (image != null)
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text("Choisir un source"),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            getImage(ImageSource.gallery)
                                                                .then((value) => Navigator.pop(context));
                                                          },
                                                          icon: const Icon(Icons.collections)),
                                                      IconButton(
                                                          onPressed: () {
                                                            getImage(ImageSource.camera)
                                                                .then((value) => Navigator.pop(context));
                                                          },
                                                          icon: const Icon(Icons.photo_camera)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1
                                        )
                                    ),
                                    child:  Center(
                                        child:  Stack(
                                          children: [
                                            Image.file(image!,
                                                fit: BoxFit.contain),

                                          ],
                                        ),
                                    ),
                                  ),
                                ),
                              ),

                            if (image == null) imagePickerIcon(context),
                            const SizedBox(height: 22,),
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * .93,
                              padding: const EdgeInsets.all(5.0),
                              margin: const EdgeInsets.all(5.0),
                              decoration: const BoxDecoration(

                                gradient: LinearGradient(
                                    colors: [
                                      Colors.purple,
                                      Colors.deepPurple,
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),

                              // alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {


                                  if (isupdate == true) {
                                    updateToLocalDataBase();
                                  } else {
                                    creeAnnonce();


                                    insertToLocalDataBase();
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                          etat: widget.etat,
                                          localisation: widget.localisation,
                                          temps: widget.temps,
                                          details: widget.details,
                                          nombre: widget.nombre,
                                          description: widget.description,
                                          imageUrl: widget.imageUrl,
                                        )));
                                  }


                                },
                                child: const Text(
                                  ' Ajouter mon annonce',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                          ]),
                    ],
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );


  }



  void insertToLocalDataBase() async {
    var res = await taskDatabaseHelper.insert({
      'etat': "$perdu",
      'localisation': localisation.text,
      'temps': DateTime.now().toString(),
      'details': details.text,
      'nombre': nombre.text,
      'description': decrire.text,
      'imageUrl': 'imageUrl',
      'issync': false,
      //'isupdate': true,
    });

    print('ffffffffffffffffffff${res}');
    if (res != -1) print('jffjjfjfjfjfjfj');

/*  using (Image image = Image.FromFile(Path))
{
    using (MemoryStream m = new MemoryImage())
    {
        image.Save(m, image.RawFormat);
        byte[] imageBytes = m.ToArray();

        // Convert byte[] to Base64 String
        string base64String = Convert.ToBase64String(imageBytes);
        return base64String;
    }
}
*/



    String base(String path) {
      final bytes = File(path).readAsBytesSync();
      String base64Image = base64Encode(bytes);
      print("img_pan : $base64Image");
      return base64Image;
    }







    Widget bottomSheet(context) {
      return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            const Text(
              'Mettez une photo',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              TextButton.icon(
                label: const Text("Camera"),
                icon: const Icon(Icons.camera),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
              ),
              TextButton.icon(
                label: const Text("Gallery"),
                icon: const Icon(Icons.image),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
              ),
            ])
          ],
        ),
      );
    }
  }

}
