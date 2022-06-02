import 'package:http/http.dart' as http;

class ChamadaApi{

  final String url ;
  final http.Client httpClient;
  ChamadaApi({
    required this.httpClient ,
    this.url = 'https://reqres.in/api/users?page=2'}
      );

  Future getData(url) async{
    return await httpClient.get(Uri.parse(url));
  }


}