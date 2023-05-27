import 'package:responsi/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();


  Future<Map<String, dynamic>> loadMatches(){
    return BaseNetwork.get("matches");
  }


  Future<Map<String, dynamic>> loadMatchesDetail(String matches){
    String matchs = matches;
    return BaseNetwork.get("matches/" + matchs);
  }


}