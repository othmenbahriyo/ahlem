
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';
import 'package:flutter_application_1/screens/auth_module/Welcome/view/Welcome_screens.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';


Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
    var statusLocation = await Permission.location.status;
    var statusBluetoothConnect = await Permission.bluetoothConnect.request();
    var statusBluetoothScan = await Permission.bluetoothScan.request();
    var statusStorage = await Permission.storage.request();

    if (statusLocation.isDenied) {
      await Permission.location.request();
    }
    if (statusBluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }
    if (statusBluetoothScan.isDenied) {
      await Permission.bluetoothScan.request();
    }
    if (statusStorage.isDenied) {
      await Permission.storage.request();
    }
    if (await Permission.location.status.isPermanentlyDenied) {
      openAppSettings();
    }
    if (await Permission.bluetoothConnect.status.isPermanentlyDenied) {
      openAppSettings();
    }
    if (await Permission.bluetoothScan.status.isPermanentlyDenied) {
      openAppSettings();
    }
    if (await Permission.storage.status.isPermanentlyDenied) {
      openAppSettings();
    }


  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: KPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
          displayColor: kBlackColor,
        )

      ),
      home: Navigator(
        pages: [
          MaterialPage(child: HelloScreen()),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          return true;
        },
      ),
    );
  }
}

class HelloScreen extends StatefulWidget {




  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 3000), () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );

    });
  }


  @override
  Widget build(BuildContext context) {
    var display;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/login.svg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Findgo",style:TextStyle(fontSize: 40,color:Colors.purple,fontWeight: FontWeight.bold)),
            Lottie.asset('assets/39612-location-animation.json'),



          ],

        ),
        )

    );
  }
}

