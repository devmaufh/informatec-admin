import 'package:avisos_admin/bloc/provider.dart';
import 'package:avisos_admin/providers/apiRepository.dart';
import 'package:avisos_admin/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _loginBackground(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180,
            ),
          ),
          Container(
            width: screenSize.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Iniciar sesión",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                _buildTextFieldEmail(bloc),
                SizedBox(
                  height: 30,
                ),
                _buildTextFieldPassword(bloc),
                SizedBox(
                  height: 30,
                ),
                _buildTextFieldEmailReal(bloc),
                SizedBox(
                  height: 30,
                ),
                _buildTextFieldTelefono(bloc),
                SizedBox(
                  height: 30,
                ),
                _buildButtonSubmit(bloc),
              ],
            ),
          ),
          Text('¿Olvidó la contraseña?',
              style: TextStyle(color: Colors.redAccent)),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _loginBackground(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final background = Container(
      height: screenSize.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.redAccent])),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.09)),
    );

    return Stack(
      children: <Widget>[
        background,
        Positioned(
          top: 50,
          left: 20,
          child: circulo,
        ),
        Positioned(
          top: -50,
          right: 0,
          child: circulo,
        ),
        Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('assets/icon.png'),
              ),
              //Icon(Icons.person, color: Colors.white,size: 100,),
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text("InformaTEC",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                errorText: snapshot.error,
                counterText: snapshot.data,
                labelText: 'Nombre de usuario'),
            onChanged: bloc.changeUser,
          ),
        );
      },
    );
  }

  Widget _buildTextFieldPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.red,
                ),
                errorText: snapshot.error,
                counterText: snapshot.data,
                labelText: 'Contraseña'),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _buildTextFieldEmailReal(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.correoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: Colors.red,
                ),
                errorText: snapshot.error,
                counterText: snapshot.data,
                labelText: 'Email'),
            onChanged: bloc.changeCorreo,
          ),
        );
      },
    );
  }

  Widget _buildTextFieldTelefono(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.telefonoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: Colors.red,
                ),
                errorText: snapshot.error,
                counterText: snapshot.data,
                labelText: 'Telefono'),
            onChanged: bloc.changeTeleono,
          ),
        );
      },
    );
  }

  Widget _buildButtonSubmit(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.validateForm,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15.0),
              child: Text("Ingresar"),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.red,
            textColor: Colors.white,
            onPressed:
                snapshot.hasData ? () => _checkLogin(bloc, context) : null,
          ),
        );
      },
    );
  }

  _checkLogin(LoginBloc bloc, BuildContext context) async {
    print("======BEGIN LOGIN====");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 25,),
              SpinKitDoubleBounce(color: Colors.red, duration: Duration(milliseconds: 1000)),
              SizedBox(height: 25,),
              new Text("Iniciando sesión"),
              SizedBox(height: 25,),
            ],
          ),
        );
      },
    );
    
    var response = await ApiRepository().login(
        correo: bloc.correo,
        noTel: bloc.telefono,
        ursId: bloc.user,
        pwd: bloc.pass);
    var accessToken = response['access_token'];
    var decodedToken = Consts.parseJWT(accessToken);
    print(decodedToken['identity']['usrId']);
    Navigator.pop(context); //pop dialog
    print("======END LOGIN====");
  }
}
