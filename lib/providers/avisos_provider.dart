import 'dart:convert';
import 'dart:io';

import 'package:avisos_admin/utils/consts.dart';
import 'package:http/http.dart' as http;

import 'package:avisos_admin/models/aviso_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class AvisosProvider {
  uploadToAp(AvisoModel model, File img)async{
    var uri = Uri.parse("${Consts.API_URL}/avisos/insert");
    var request = http.MultipartRequest("POST",uri);
    if(img!= null){
      final mimetype = mime(img.path).split('/');
      final finalFile = await http.MultipartFile.fromPath('img', img.path,
            contentType: MediaType(mimetype[0], mimetype[1]));
      request.files.add(finalFile);
    }
    request.fields['usrId'] = model.usrId;
    request.fields['titulo'] = model.titulo;
    request.fields['descripcion'] = model.descripcion;
    request.fields['fechaFin'] = model.fechaFin.toIso8601String();
    request.fields['fechaAlta'] = model.fechaAlta.toIso8601String();
    request.fields['prioridad'] = model.prioridad.toString();
    var response = await request.send();
    print(response);
  }


  getAll()async{
    var request = await http.get('${Consts.API_URL}/avisos');
    if(request.statusCode ==200 || request.statusCode == 201){
      var response = json.decode(request.body);
      List<AvisoModel> listaAvisos = (response['avisos'] as List).map((i)=> AvisoModel.fromJson(i)).toList();
      return listaAvisos;
    }else{
      return [];
    }
  }

}

/*
var request = new http.MultipartRequest("POST", uri);
    request.fields['user'] = 'nweiz@google.com';
    request.files.add(new http.MultipartFile.fromPath(
        'package',
        'build/package.tar.gz',
        contentType: new MediaType('application', 'x-tar'));
    var response = await request.send();
    if (response.statusCode == 200) print('Uploaded!');


*/