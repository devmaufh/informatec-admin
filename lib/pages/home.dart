import 'package:avisos_admin/pages/avisos.dart';
import 'package:avisos_admin/pages/profile.dart';
import 'package:avisos_admin/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> userData={};

  @override
  void initState() { 
    super.initState();
    getUserData();
  }

  void getUserData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(Consts.USER_ID);
    var name = prefs.getString(Consts.USER_NAME);
    var email = prefs.getString(Consts.USER_MAIL);
    var phone = prefs.getString(Consts.USER_PHONE);
    setState(() {
     userData[Consts.USER_ID] = userId;
     userData[Consts.USER_NAME] = name;
     userData[Consts.USER_MAIL] = email;
     userData[Consts.USER_PHONE] = phone;
     print(userData); 
    });
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red
    ));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("InformaTEC"),
      ),
      body:_callPage(currentIndex),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alert),
        onPressed: (){
          Navigator.pushNamed(context, 'aviso');
        },

      ),
    );
  }

  Widget _buildBottomNav(){
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
         currentIndex = index; 
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active),
          title: Text("Avisos")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text("Perfil")
        )
      ],
    );
  }

  Widget _callPage( int currentPage){
    switch (currentPage) {
      case 0: return AvisosPage();
      case 1: return ProfilePage(userData: userData,);
      default: return AvisosPage();
    }
  }
}