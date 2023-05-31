import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/model/detail_matches_model.dart';
import 'package:responsi/service/base_network.dart';

class MatchDetail extends StatelessWidget {
  String id;
  MatchDetail({super.key,
  required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Match ID : ' + id)),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: BaseNetwork.get('matches/$id'),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              }else if (!snapshot.hasData){
                return Text("No data, min");
              }else {
                DetailMatchesModel detailMatch = DetailMatchesModel.fromJson(snapshot.data);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.network('https://flagcdn.com/256x192/${detailMatch.homeTeam!.country!.substring(0, 2).toLowerCase()}.png',
                                fit: BoxFit.cover,
                                ),

                              ),
                              Text(detailMatch.homeTeam!.name!),
                            ],
                          ),
                          Row(
                            children: [
                              Text(detailMatch.homeTeam!.goals!.toString()),
                              SizedBox(width: 10,),
                              Text("-"),
                              SizedBox(width: 15,),
                              Text(detailMatch.awayTeam!.goals!.toString()),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.network('https://flagcdn.com/256x192/${detailMatch.awayTeam!.country!.substring(0, 2).toLowerCase()}.png',
                                fit: BoxFit.cover,
                                ),
                              ),
                              Text(detailMatch.awayTeam!.name!),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      Text('Stadium : ' + detailMatch.venue!),
                      SizedBox(height: 15,),
                      Text('Location : ' + detailMatch.location!),
                      SizedBox(height: 15,),

                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Statistics', style: TextStyle(fontSize: 20),),
                                    SizedBox(height: 5,),
                                    
                                    _statsDetail(
                                      title: 'Ball Possession',
                                      left: detailMatch.homeTeam!.statistics!.ballPossession!,
                                      right: detailMatch.awayTeam!.statistics!.ballPossession!
                                    ),
                                    _statsDetail(
                                      title: 'Shot',
                                      left: detailMatch.homeTeam!.statistics!.attemptsOnGoal,
                                      right: detailMatch.awayTeam!.statistics!.attemptsOnGoal
                                    ),
                                    _statsDetail(
                                      title: 'Shot on Goal',
                                      left: detailMatch.homeTeam!.statistics!.kicksOnTarget,
                                      right: detailMatch.awayTeam!.statistics!.kicksOnTarget
                                    ),
                                    _statsDetail(
                                      title: 'Corners',
                                      left: detailMatch.homeTeam!.statistics!.corners,
                                      right: detailMatch.awayTeam!.statistics!.corners
                                    ),
                                    _statsDetail(
                                      title: 'Offside',
                                      left: detailMatch.homeTeam!.statistics!.offsides,
                                      right: detailMatch.awayTeam!.statistics!.offsides
                                    ),
                                    _statsDetail(
                                      title: 'Fouls',
                                      left: detailMatch.homeTeam!.statistics!.foulsReceived,
                                      right: detailMatch.awayTeam!.statistics!.foulsReceived
                                    ),
                                    _statsDetail(
                                      title: 'Pass Accuracy',
                                      left: _averageResult(detailMatch.homeTeam!.statistics!.passesCompleted!, detailMatch.homeTeam!.statistics!.passes!),
                                      right: _averageResult(detailMatch.awayTeam!.statistics!.passesCompleted!, detailMatch.awayTeam!.statistics!.passes!)
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text('Referees : ', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for(int boxs = 0; boxs <detailMatch.officials!.length; boxs++)
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              padding: EdgeInsets.only(right: 15),
                              child: Table(
                                border: TableBorder.all(), 
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        height: 200,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width / 6,
                                              child: Image.asset('assets/images/FIFA_logo_without_slogan.svg.png'),
                                            ),
                                            Text(detailMatch.officials![boxs].name!, textAlign: TextAlign.center,),
                                            Text(detailMatch.officials![boxs].role!, textAlign: TextAlign.center),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )


                    ]),
                );
              }
            }
            
            ),
        )
        ),


    );
  }
}

String _averageResult(int complete, int total) {
  int results = ((complete / total) * 100).ceil();
  return (results).toString() + "%";
}

Widget _statsDetail({title, left, right}) {
  return Column(
    children: [
      SizedBox(height: 5,),
      Text('$title'),
      SizedBox(height: 5,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('$left'),
          Text("-"),
          Text('$right'),
        ],
      )
    ],
  );
}