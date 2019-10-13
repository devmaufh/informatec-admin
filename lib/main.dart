import 'package:avisos_admin/bloc/provider.dart';
import 'package:avisos_admin/pages/aviso.dart';
import 'package:avisos_admin/pages/home.dart';
import 'package:avisos_admin/pages/login.dart';
import 'package:avisos_admin/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String s = prefs.getString(Consts.USER_ID);
  String initial = 'login';
  print(s);
  if(s != null) initial = 'home'; 
  runApp(MyApp(initial));
}

class MyApp extends StatefulWidget {
 final String initialRoute;
 MyApp(this.initialRoute);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: widget.initialRoute,
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),    
          'aviso': (BuildContext context) => AvisoPage(),    
                
        },
      ),
    );
  }
}
