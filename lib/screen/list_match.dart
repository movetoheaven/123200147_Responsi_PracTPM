import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/screen/match_detail.dart';
import 'package:responsi/model/matches_model.dart';
import 'package:responsi/service/base_network.dart';



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

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: BaseNetwork.getList('matches'),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return _buildLoadingSection();
              }else if (!snapshot.hasData) {
                return _buildErrorSection();
              }else{
                List<MatchesModel> matches = [];
                for (var item in snapshot.data) {
                  matches.add(MatchesModel.fromJson(item));
                }
                return ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index){
                    MatchesModel matchs = matches[index];

                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=> MatchDetail(id: matchs.id!),
                          )
                          );
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width / 3,
                                          child: Image.network(
                                            'https://flagcdn.com/256x192/${matchs.homeTeam!.country!.substring(0, 2).toLowerCase()}.png',
                                            fit: BoxFit.cover,
                                          ),
                                      ),
                                        Text(matchs.homeTeam!.name!),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(matchs.homeTeam!.goals!.toString()),
                                      SizedBox(width: 15,),
                                      Text('-'),
                                      SizedBox(width: 15,),
                                      Text(matchs.awayTeam!.goals!.toString()),
                                    ],
                                  ),
                                    Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          child: Image.network(
                                             'https://flagcdn.com/256x192/${matchs.awayTeam!.country!.substring(0, 2).toLowerCase()}.png',
                                             fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(matchs.awayTeam!.name!)
                                      ],
                                    ),


                                ],
                              ),

                          ),
                        ),

                    );
                  },
                  );
              }
            },
            ),
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
