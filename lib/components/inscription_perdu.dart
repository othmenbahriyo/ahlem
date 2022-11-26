
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'declarer_objet.dart';
import 'package:flutter_application_1/components/inscription_perdu.dart';
class InscriptionPerduScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            const Center(
              child: Text('Vous Avez Perdu ou Trouvé un objet ?'),
            ),
            SizedBox(height: 10.0,
              width: MediaQuery.of(context).size.width * .6,
              child: const RoundedButton(
                
                text: "Trouvé",
                fontsize: 20,
            
              )),
              SizedBox(
                height: 10.0,
                width: MediaQuery.of(context).size.width * .6,
                child: RoundedButton(
                  text: "Perdu" ,
                  fontsize: 20,
                  onPressed: () {
                     Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => DeclarerObjetScreen(description:"" ,
                        details:"", localisation: "", etat: "", temps: "", nombre: "", imageUrl: ""),
                
                        ),
                     );
                },
                     
            
              )),  
              ]),
      ),
          
    );
  }
}

