import 'package:fast_shop/blocs/listas_page_bloc.dart';
import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/listas.dart';
import 'package:fast_shop/pages/add_listado.dart';
import 'package:fast_shop/blocs/add_listado_page_bloc.dart';
import 'package:fast_shop/blocs/add_listado_page_provider.dart';
import 'package:flutter/material.dart';

class ListadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ListaBloc bloc = BlocProvider.of<ListaBloc>(context);
    return Scaffold(
        body: 
     StreamBuilder<List<Lista>>(
      stream: bloc.outListadoList,
      builder: (BuildContext context, AsyncSnapshot<List<Lista>> snapshot) {
        if (!snapshot.hasData)
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        return ListView.builder(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            Lista listado = snapshot.data.elementAt(index);

            final baseTextStyle = const TextStyle(fontFamily: 'Raleway');
            final subHeaderTextStyle = baseTextStyle.copyWith(
                fontSize: 18.0,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w400);
            final headerTextStyle = baseTextStyle.copyWith(
                color: Colors.blue.shade900,
                fontSize: 34.0,
                fontWeight: FontWeight.w600);

            final listadoContent = Container(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              constraints: BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 4.0),
                  Text(
                    listado.descripcion,
                    style: headerTextStyle,
                    maxLines: 1,
                    textScaleFactor: 0.9,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //  Container(height: 10.0),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      height: 2.4,
                      width: 140.0,
                      color: Colors.red),
                  Text(listado.fechaCreacion, style: subHeaderTextStyle),
                ],
              ),
            );

            return Container(
              child: listadoContent,
              height: 120.0,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.amber.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          },
        );
      },
    ),
    floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => AddListadoPageBlocProvider(
                      listadoBloc: AddListadoBloc(),
                      child: AddListadoPage(),
                    ),
              ),
            );
          }
    ),
    );
  }
  // void _navigateToCurrentPlaying(BuildContext context, Lista listado) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return BlocProvider<CurrentAlbumBloc>(
  //         bloc: CurrentAlbumBloc(listado.id),
  //         child: CurrentAlbumPage(
  //           listado: listado,
  //         ),
  //       );
  //     }),
  //   );
  // }
}
