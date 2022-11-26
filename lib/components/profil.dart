import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


// our data
const name = "ahlem manei";
const email = "ahlem.manei@isimg.tn";
const phone = "52422414"; // not real number :)
const location = "sfax";

class Profil extends StatelessWidget {
  //const InfoCard({Key? key, Text? text, Icon? icon, })
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Card(
          child: Column(
            children: <Widget>[
              Lottie.asset('assets/50124-user-profile.json'),
              Text(
                "Shivansh Singh",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              Text(
                "Flutter Developer",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey[200],
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              // we will be creating a new widget name info carrd

              // InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
              // InfoCard(text: name, icon: Icons.person, onPressed: () async {}),
              // InfoCard(text: location, icon: Icons.location_city, onPressed: () async {}),
              // InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            ],
          ),
        )));
  }
}