import 'package:avisos_admin/bloc/aviso_bloc.dart';
import 'package:avisos_admin/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  final Map<String,dynamic> userData;
  const ProfilePage({Key key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        children: <Widget>[
          _profileBack(context),
          Center(
                child: _buildUserStats(context),
              ),
        ],
      ),
    );
  }

  Widget _profileBack(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final background = Container(
      height: screenSize.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.red, BlendMode.color),
            image: AssetImage('assets/back.png'),
            fit: BoxFit.cover),
      ),
    );
    return Stack(children: <Widget>[
      background,
    ]);
  }

  Widget _buildUserStats(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              width: screenSize.width * 0.85,
              padding: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text('Mi perfil', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.recent_actors,
                          color: Colors.white,
                        )),
                    title: Text(
                      userData[Consts.USER_ID],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Nombre de usuario"),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.red,
                        )),
                    title: Text(
                      userData[Consts.USER_NAME],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Nombre"),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.email,
                          color: Colors.red,
                        )),
                    title: Text(
                      userData[Consts.USER_MAIL],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Correo electrónico"),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.phone,
                          color: Colors.red,
                        )),
                    title: Text(
                      userData[Consts.USER_PHONE],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Telefono"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15,),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: screenSize.width*0.15),
            trailing: Icon(Icons.exit_to_app, color: Colors.red,),
            title: Text('Cerrar sesión', textAlign: TextAlign.right,style: TextStyle(color: Colors.red),),
            onTap: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pushNamed(context, 'login');
            },
          )
        ],
      ),
    );
  }
}
