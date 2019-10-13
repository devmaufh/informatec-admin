import 'dart:io';

import 'package:avisos_admin/bloc/aviso_bloc.dart';
import 'package:avisos_admin/bloc/provider.dart';
import 'package:avisos_admin/models/aviso_model.dart';
import 'package:avisos_admin/providers/avisos_provider.dart';
import 'package:avisos_admin/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvisoPage extends StatefulWidget {
  AvisoPage({Key key}) : super(key: key);

  AvisoPageState createState() => AvisoPageState();
}

class AvisoPageState extends State<AvisoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AvisoBloc avisosBloc;
  AvisoModel avisoModel = new AvisoModel(
    usrId: '0',
    titulo: ' ',
    prioridad: 0,
    img: null,
    descripcion: ' ',
    fechaAlta: null,
    fechaFin: null,
  );
  File foto;

  @override
  Widget build(BuildContext context) {
    avisosBloc = Provider.avisosBloc(context);
    final AvisoModel avisoData = ModalRoute.of(context).settings.arguments;

    if (avisoData != null) {
      avisoModel = avisoData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Aviso'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTitle(),
                SizedBox(height: 10),
                _buildDescription(),
                SizedBox(height: 10),
                _buildInitialDate(context),
                SizedBox(height: 10),
                _buildEndlDate(context),
                SizedBox(height: 10),
                _buildFoto(context),
                SizedBox(height: 10),
                _buildPrioritario(),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    child: Text("Guardar"),
                    onPressed: _submit,
                    textColor: Colors.red,
                    hoverColor: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return TextFormField(
      initialValue: avisoModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Titulo',
        prefixIcon: Icon(Icons.title),
      ),
      onSaved: (text) => avisoModel.titulo = text,
      validator: (title) {
        if (title.length <= 1) return 'Ingresa un titulo válido';
        if (title.length > 60) return 'No puedes exceder los 60 caracteres';
        return null;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      initialValue: avisoModel.descripcion,
      decoration: InputDecoration(
        labelText: 'Descripción',
        prefixIcon: Icon(Icons.description),
      ),
      maxLines: null,
      onSaved: (text) => avisoModel.descripcion = text,
      validator: (descripcion) {
        if (descripcion.length <= 1) return 'Ingresa una descripción válida';
        if (descripcion.length > 255) return 'Descripción demasiado muy larga';
        return null;
      },
    );
  }

  Widget _buildInitialDate(BuildContext context) {
    var current =
        avisoModel.fechaAlta == null ? DateTime.now() : avisoModel.fechaAlta;

    TextEditingController controller = TextEditingController();
    controller.text = avisoModel.fechaAlta == null
        ? ''
        : '${avisoModel.fechaAlta.year.toString()}-${avisoModel.fechaAlta.month.toString().padLeft(2, '0')}-${avisoModel.fechaAlta.day.toString().padLeft(2, '0')}';
    return TextFormField(
      onTap: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true, minTime: DateTime.now(), onConfirm: (date) {
          setState(() {
            avisoModel.fechaAlta = date;
            controller.text =
                ' ${avisoModel.fechaAlta.year.toString()}-${avisoModel.fechaAlta.month.toString().padLeft(2, '0')}-${avisoModel.fechaAlta.day.toString().padLeft(2, '0')}';
          });
          Consts.printWithColor("GREEN", date.toIso8601String());
        }, currentTime: current, locale: LocaleType.es);
      },
      focusNode: AlwaysDisabledFocusNode(),
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Fecha inicial',
        prefixIcon: Icon(Icons.calendar_today),
      ),
      maxLines: null,
      validator: (date) {
        if (date.length <= 1) return 'Ingresa una fecha válida';
        return null;
      },
    );
  }

  Widget _buildEndlDate(BuildContext context) {
    var current =
        avisoModel.fechaFin == null ? DateTime.now() : avisoModel.fechaFin;
    var min =
        avisoModel.fechaAlta == null ? DateTime.now() : avisoModel.fechaAlta;

    TextEditingController controller = TextEditingController();
    controller.text = avisoModel.fechaFin == null
        ? ''
        : '${avisoModel.fechaFin.year.toString()}-${avisoModel.fechaFin.month.toString().padLeft(2, '0')}-${avisoModel.fechaFin.day.toString().padLeft(2, '0')}';
    return TextFormField(
      onTap: () {
        DatePicker.showDatePicker(context, showTitleActions: true, minTime: min,
            onConfirm: (date) {
          setState(() {
            avisoModel.fechaFin = date;
            controller.text =
                ' ${avisoModel.fechaFin.year.toString()}-${avisoModel.fechaFin.month.toString().padLeft(2, '0')}-${avisoModel.fechaFin.day.toString().padLeft(2, '0')}';
          });
          Consts.printWithColor("GREEN", date.toIso8601String());
        }, currentTime: current, locale: LocaleType.es);
      },
      focusNode: AlwaysDisabledFocusNode(),
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Fecha de vencimiento',
        prefixIcon: Icon(Icons.calendar_today),
      ),
      maxLines: null,
      validator: (date) {
        if (date.length <= 1) return 'Ingresa una fecha válida';
        return null;
      },
    );
  }

  Widget _buildFoto(BuildContext context) {
    if (avisoModel.img != null) {
      return GestureDetector(
        onTapUp: (flag) => pickImage(),
        child: FadeInImage(
          image: NetworkImage("${Consts.API_URL}/images/${avisoModel.img}"),
          placeholder: AssetImage('assets/jar-loading.gif'),
          height: 250.0,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return GestureDetector(
        onTapUp: (flag) => pickImage(),
        child: Image(
          image: AssetImage(foto?.path ?? 'assets/no-image.png'),
          height: 250.0,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  bool value = true;
  Widget _buildPrioritario() {
    return Row(
      children: <Widget>[
        Text("Marca la casilla si el mensaje es prioritario"),
        Checkbox(
          onChanged: (bool val) {
            print("on cahnged");
            setState(() {
              value = val;
            });
          },
          value: value,
        )
      ],
    );
  }

  void pickImage() async {
    foto = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (foto != null) {
      print("File no es nulo");
      avisoModel.img = null;
    }
    setState(() {});
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    var prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString(Consts.USER_ID);
    avisoModel.usrId = user_id;
    avisoModel.prioridad = value ? 1 : 0;
    print(avisoModel.toJson());

    if (avisoModel.idAviso == null) {
      var res = await avisosBloc.addAviso(avisoModel, foto);
      if (res) {
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 25,),
                  Icon(Icons.error, color: Colors.red,size: 30,),
                  SizedBox(height: 25,),
                  new Text("Error al insertar, verifica tu conexión a internet", textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
                  SizedBox(height: 25,),
                ],
              ),
            );
          },
        );
      }
    } else {
      //Editar
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
