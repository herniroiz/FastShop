import 'package:fast_shop/blocs/listas_page_bloc.dart';
import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/listas.dart';
import 'package:flutter/material.dart';

class ListadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ListaPageBloc bloc = BlocProvider.of<ListaPageBloc>(context);
    return StreamBuilder<List<Lista>>(
      stream: bloc.listadoStream,
      builder: (BuildContext context, AsyncSnapshot<List<Lista>> snapshot) {
        if (!snapshot.hasData)
          return Container(
            child: Center(child: Text("Cargando Listas....")),
          );
        return ListView.builder(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            Lista listado = snapshot.data.elementAt(index);


    final baseTextStyle = const TextStyle(
      fontFamily: 'Raleway'
    );
    final subHeaderTextStyle = baseTextStyle.copyWith(
      fontSize: 18.0,
      color: Colors.blue.shade900,
      fontWeight: FontWeight.w400
    );
    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.blue.shade900,
      fontSize: 34.0,
      fontWeight: FontWeight.w600
    );



    final listadoContent =  Container(
      margin:  EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      constraints:  BoxConstraints.expand(),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Container(height: 4.0),
           Text(listado.descripcion, 
            style: headerTextStyle, 
            maxLines: 1, 
            textScaleFactor: 0.9, 
            overflow: TextOverflow.ellipsis,
           ),
          //  Container(height: 10.0),
           Container(
            margin:  EdgeInsets.symmetric(vertical: 8.0),
            height: 2.4,
            width: 140.0,
            color:  Colors.red
          ),
           Text(listado.fechaCreacion, style: subHeaderTextStyle),
        ],
      ),
    );


      return Container(
      child: listadoContent,
      height: 120.0,
      margin:  EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      decoration:  BoxDecoration(
        color:  Colors.amber.shade200,
        shape: BoxShape.rectangle,
        borderRadius:  BorderRadius.circular(8.0),
        // boxShadow: <BoxShadow>[
        //    BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 10.0,
        //     offset:  Offset(0.0, 10.0),
        //   ),
        // ],
      ),
    );







            // return GestureDetector(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //     child: Row(
            //       children: <Widget>[
            //         Expanded(
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
            //                 Text(
            //                   "${listado.descripcion}",
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 20.0,
            //                       color: Color(0xFF444444)),
            //                 ),
            //                 Text(
            //                   "${listado.fechaCreacion}",
            //                   style: TextStyle(
            //                       fontSize: 15.0,
            //                       color: Colors.grey,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   onTap: () => print("lista ${listado.id}"),
            // );
          },
        );
      },
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