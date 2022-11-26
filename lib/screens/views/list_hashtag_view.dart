
import 'package:flutter/material.dart';
final List<Map<String, dynamic>> ListHashtag = [
   {
    'name': '#flutter',
   },
   {
    'name': '#dart',
   },
];
      
class ListHashtagView extends StatelessWidget {
  ListHashtagView({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListHashtag.isEmpty
     ? const Center(
        child: Text('No hashtags'),
       )
     : ListView.builder(
        itemCount: ListHashtag.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(index.toString()),
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$index dismissed'),
                ),
              );
            },
          background: Container(
            color: Colors.red,
          ),
          child: Card(
            child: ListTile(
              title: Text(
                
                '${ListHashtag[index]['name']}'
              ),
            ),
          ),
        );
        
      },
      
    
    );
  }
}