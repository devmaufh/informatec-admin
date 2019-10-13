import 'dart:async';

class Validators {

  final validateGeneric = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink){
      if(data.length>0){
        sink.add('Campo correcto');
      }else sink.addError('Campo obligatorio');
    }
  );
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData:  (password, sink){
      if( password.length >=6 ){
        sink.add("Campo correcto");
      }else sink.addError("Tienes que agregar mínimo 6 caracteres");
    }
  );
  final validateEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink){
      String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
      RegExp regExp = new RegExp(pattern);
      if(regExp.hasMatch(email)){
        sink.add('Correo correcto');
      }else{
        sink.addError('Ingresa un correo valido');
      }
    }
  );
  final validateNumebr = StreamTransformer<String,String>.fromHandlers(
    handleData: (number, sink){
      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = new RegExp(patttern);
      if(regExp.hasMatch(number) && number.length ==10) sink.add('Campo correcto');
      else sink.addError('Ingresa un número válido');
    }
  );

  final validateTitulo60 = StreamTransformer<String,String>.fromHandlers(
    handleData: (titulo,sink){
      if(titulo.length==0) sink.addError('Ingresa un titulo válido');
      if(titulo.length>60) sink.addError('No puedes exceder los 60 caracteres');
    }
  );
  final validateDescripcion255 = StreamTransformer<String,String>.fromHandlers(
    handleData: (titulo,sink){
      if(titulo.length==0) sink.addError('Ingresa un titulo válido');
      if(titulo.length>255) sink.addError('No puedes exceder los 255 caracteres');
    }
  );
  
  
}