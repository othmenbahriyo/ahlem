
//     import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/views/list_hashtag_view.dart';
//     import 'package:http/http.dart' as http;
//     class DisplayUsers extends StatefulWidget {
//       @override
//       _DisplayUsersState createState() => _DisplayUsersState();
//     }
//     class _DisplayUsersState extends State<DisplayUsers> {
//       List<ListHashtagView> user = [];
//       Future<List<ListHashtagView>> getAll() async {
//         var response = await http.get(Uri.parse("http://localhost:1337/api/"));
      
//         if(response.statusCode==200){
//           user.clear();
//         }
//         var decodedData = jsonDecode(response.body);
//         for (var u in decodedData) {
//           ListHashtag.add(ListHashtagView());
//         }
//         return ListHashtag();
//       }
//       @override
//       Widget build(BuildContext context) {
//         getAll();
//         return Scaffold(
//             appBar: AppBar(
//               title: Text('Display Users'),
//               elevation: 0.0,
//               backgroundColor: Colors.indigo[700],
//             ),
//             body: FutureBuilder(
//                 future: getAll(),
//                 builder: (context, AsyncSnapshot<List<ListHashtagView>> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                     return ListView.builder(
//                       itemCount: ListHashtag.length,
//                       itemBuilder: (context, index) => 
//                       InkWell(
//                         child: ListTile(),
//                       )
//                     );
//                   }
//                 ));
//       }
//     }