import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/model/matches_model.dart';

import 'model/api.dart';

class ListMatch extends StatefulWidget {
  const ListMatch({super.key});

  @override
  State<ListMatch> createState() => _ListMatchState();
}

class _ListMatchState extends State<ListMatch> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Piala Dunia 2022"),
      ),

      body: FutureBuilder(
        future: ApiDataSource.instance.loadMatches(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
          if (snapshot.hasError) {
            return _buildErrorSection();
          }if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: Image.network('flagcdn.com/256x192/qa.png'),
                    title: Text(snapshot.data[index]),
                  ),
                );
              }
              
            );
          } else {
            return _buildLoadingSection();
          }
        },
        
        )

    ));
  }
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Error min"),
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}
