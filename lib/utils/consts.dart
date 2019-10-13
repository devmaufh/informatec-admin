import 'dart:convert';

class Consts {
  Consts._();
  static String API_URL = "http://192.168.1.69:5000";

/*
{usrId: rfc1, nomUsr: Juan daniel torres moreno, noTel: 4612180325, correo: ad@d.com, rfcTutor: null, fechaAlta: Tue, 01 Oct 2019 00:00:00 GMT, idTipoUsr: 3}
*/
  static const String USER_ID    = "usrId";
  static const String USER_NAME  = "nomUsr";
  static const String USER_PHONE = "noTel";
  static const String USER_MAIL  = "correo";
  static const String USER_TYPE  = "idTipoUsr"; 


  static Map<String, dynamic> parseJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  }

  static _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static void printWithColor(String color, String message) {
    switch (color.toUpperCase().trim()) {
      case "BLACK":
        print('\x1B[30m' + message + '\x1B[0m');
        break;

      case "RED":
        print('\x1B[31m' + message + '\x1B[0m');
        break;

      case "GREEN":
        print('\x1B[32m' + message + '\x1B[0m');
        break;

      case "YELLOW":
        print('\x1B[33m' + message + '\x1B[0m');
        break;

      case "BLUE":
        print('\x1B[34m' + message + '\x1B[0m');
        break;

      case "MAGENTA":
        print('\x1B[35m' + message + '\x1B[0m');
        break;

      case "CYAN":
        print('\x1B[36m' + message + '\x1B[0m');
        break;
    }
  }


  
}
