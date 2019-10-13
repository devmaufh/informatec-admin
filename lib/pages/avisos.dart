import 'package:avisos_admin/bloc/aviso_bloc.dart';
import 'package:avisos_admin/bloc/provider.dart';
import 'package:avisos_admin/models/aviso_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AvisosPage extends StatelessWidget {
  const AvisosPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final avisosBloc = Provider.avisosBloc(context);
    avisosBloc.loadAvisos();
    return Container(
      child: Center(
        child: RefreshIndicator(
          child: StreamBuilder(
            stream: avisosBloc.avisosStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<AvisoModel>> snapshot) {
              if (snapshot.hasData) {
                final avisos = snapshot.data;
                return ListView.builder(
                  itemCount: avisos.length,
                  itemBuilder: (context, i) {
                    return _buildItemList(context, avisosBloc, avisos[i]);
                  },
                );
              } else {
                return Center(
                  child: SpinKitDoubleBounce(
                      color: Colors.red,
                      duration: Duration(milliseconds: 1000)),
                );
              }
            },
          ),
          onRefresh: () async {
            avisosBloc.loadAvisos();
            print("Aver");
          } ,
        ),
      ),
    );
  }

  
  Widget _buildItemList(
      BuildContext context, AvisoBloc bloc, AvisoModel model) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        color: Colors.red,
      ),
      onDismissed: (direction) => print("Borrar ${model.idAviso}"),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              left: 15,
            ),
            title: Text(
              model.titulo,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(model.descripcion),
            onTap: () {
              Navigator.pushNamed(context, 'aviso', arguments: model);
            },
          ),
          Divider(),
        ],
      ),
    );
  }


  

}
