import 'dart:async';

import 'package:avisos_admin/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';


class LoginBloc with Validators{
  final _userController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _telefonoController = BehaviorSubject<String>();
  final _correoController  = BehaviorSubject<String>();

  //Get Stream data
  Stream<String> get userStream     => _userController.stream.transform(validateGeneric);
  Stream<String> get passwordStream => _passwordController.stream.transform( validateGeneric );
  Stream<String> get telefonoStream => _telefonoController.stream.transform( validateNumebr );
  Stream<String> get correoStream   => _correoController.stream.transform(validateEmail);      

  Stream<bool>   get formValidate   => Observable.combineLatest2(userStream, passwordStream, (u,p) => true); 
  Stream<bool>   get validateForm   => Observable.combineLatest4(userStream, passwordStream, telefonoStream, correoStream, (u,p,t,c)=>true);
  

  //Change stream data
  Function(String) get  changeUser     => _userController.sink.add;
  Function(String) get  changePassword => _passwordController.sink.add;
  Function(String) get  changeTeleono  => _telefonoController.sink.add;
  Function(String) get  changeCorreo   => _correoController.sink.add;


  //get Stream Values
  String get user     => _userController.value;
  String get pass     => _passwordController.value;
  String get correo   => _correoController.value;
  String get telefono => _telefonoController.value;


  //Dispose controllers;
  dispose(){
    _userController?.close();
    _passwordController?.close();
    _correoController?.close();
    _telefonoController?.close();
  }
 
}