import 'dart:io';

import 'package:avisos_admin/models/aviso_model.dart';
import 'package:avisos_admin/providers/avisos_provider.dart';
import 'package:avisos_admin/providers/database_provider.dart';
import 'package:avisos_admin/utils/consts.dart';
import 'package:rxdart/rxdart.dart';

class AvisoBloc {
  final _avisosController = new BehaviorSubject<List<AvisoModel>>();
  final _cargandoController = BehaviorSubject<bool>();
  final _avisosProvider = AvisosProvider();

  Stream<List<AvisoModel>> get avisosStream => _avisosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void loadAvisos() async {
    var flag = await Consts.checkInternetConnection();
    if (flag) {
      List<AvisoModel> avisosApi = await _avisosProvider.getAll();
      if (avisosApi != false) {
        DbProvider.db.deleteAllAvisos();
        avisosApi.forEach((aviso) {
          DbProvider.db.insertAviso(aviso);
          Consts.printWithColor("GREEN", "Aviso insertado : ${aviso.idAviso}");
        });
        _avisosController.sink.add(avisosApi);
      }
    } else {
      Consts.printWithColor("YELLOW", "AVISOS CARGADOS DE LA BD");
      var avisos = await DbProvider.db.getAvisos();
      _avisosController.sink.add(avisos);
    }
  }

  Future<bool> addAviso(AvisoModel model, File img) async {
    var flag = await Consts.checkInternetConnection();
    if(flag){
      _cargandoController.sink.add(true);
      await _avisosProvider.uploadToAp(model, img);
      _cargandoController.sink.add(false);
      return true;
    }
    return false;
    
  }

  void deleteAvisos(){
    DbProvider.db.deleteAllAvisos();
  }


  dispose() {
    _avisosController?.close();
    _cargandoController?.close();
  }
}
