import 'package:http/http.dart' as http;
import 'package:volaabdoshalaby/constant/constant.dart';

class WebService {
  Future<dynamic> getAgent() async {
    final response =
  //spanish language use "$url/agents?language=es-ES"
  await http.get(Uri.parse('$url/agents'),
      headers: {
        'Content-Type': 'application/json',
        'data': ['data'].toString(),
      });

  return response;
  }
}
