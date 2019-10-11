import 'package:avisos_admin/utils/consts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiRepository {
  static final ApiRepository _singleton = ApiRepository._internal();
  factory ApiRepository() {
    return _singleton;
  }
  ApiRepository._internal();

  /*
      usrId,pwd, noTel, correo
  */
  Future<Map<String, dynamic>> login(
      {String ursId, String pwd, String noTel, String correo}) async {
    var data = {
      "usrId": "rfc1",
      "pwd": "aspapdsp",
      "noTel": "1234567897",
      "correo": "actualizado@gmail.com"
    };
    final request = await http.post(
      "${Consts.API_URL}/login",
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    ).timeout(const Duration (seconds:30),onTimeout :(){
      return null;
    });
    if (request!=null && request.statusCode == 200) {
      var response = json.decode(request.body);
      return response;
    } else {
      return null;
    }
  }
}
