import 'package:avisos_admin/pages/avisos.dart';
import 'package:avisos_admin/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      case 1: return ProfilePage();
      default: return AvisosPage();
    }
  }
}