
import 'dart:io';

import 'package:avisos_admin/models/aviso_model.dart';
import 'package:avisos_admin/providers/avisos_provider.dart';
import 'package:rxdart/rxdart.dart';

class AvisoBloc {
  final _avisosController = new BehaviorSubject<List<AvisoModel>>();
  final _cargandoController = BehaviorSubject<bool>();
  final _avisosProvider = AvisosProvider();

  Stream<List<AvisoModel>> get avisosStream => _avisosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void loadAvisos()async{
    final avisos = await _avisosProvider.getAll();
    _avisosController.sink.add(avisos);
  }  

  void addAviso(AvisoModel model, File img) async{
    _cargandoController.sink.add(true);
    await _avisosProvider.uploadToAp(model, img);
    _cargandoController.sink.add(false);
  }

  dispose(){
    _avisosController?.close();
    _cargandoController?.close();
  }
}