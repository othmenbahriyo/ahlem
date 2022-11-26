import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestConnexion extends StatefulWidget {

  const TestConnexion({
    Key? key 
    }) : super(key: key);

  @override
  State<TestConnexion> createState() => _TestConnexionState();
}

class _TestConnexionState extends State<TestConnexion> {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _streamSubscription;
Future<void> initConnectivity() async {
  late ConnectivityResult result;
  try{
    result = await _connectivity.checkConnectivity();
  } on PlatformException catch (e) {
    print(e.toString());
    return;
  }
  if (!mounted) {
    return Future.value(null);
  }
  return _updateConnectionStatus(result);
}
Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  setState(() {
    _connectivityResult = result;
  });
}

 @override
 void initState() {
  super.initState();
  initConnectivity();
  _streamSubscription = 
     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
}
  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Connection Status: ${_connectivityResult.toString()}'),
      ),
    );
  }
}