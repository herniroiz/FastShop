import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/blocs/carrito_bloc.dart';
import 'package:fast_shop/models/producto.dart';
import 'package:fast_shop/widgets/barcode_scanner_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class CarritoPage extends StatelessWidget {
  String qr;
  bool camState = true;

  @override
  Widget build(BuildContext context) {
    final CarritoBloc bloc = BlocProvider.of<CarritoBloc>(context);
    return new Scaffold(
      body: StreamBuilder<List<Producto>>(
      stream: bloc.outCarrito,
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (!snapshot.hasData)
          return Container(
            child: Center(
              child: Text("El carrito esta vacio... escanea productos!!"),
            ),
          );
        return ListView.builder(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            Producto producto = snapshot.data.elementAt(index);

            final baseTextStyle = const TextStyle(fontFamily: 'Raleway');
            final subHeaderTextStyle = baseTextStyle.copyWith(
                fontSize: 18.0,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w400);
            final headerTextStyle = baseTextStyle.copyWith(
                color: Colors.blue.shade900,
                fontSize: 34.0,
                fontWeight: FontWeight.w600);

            final productoContent = Container(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              constraints: BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 4.0),
                  Text(
                    producto.descripcion,
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
                  Text('\$' + producto.precio.toString(), style: subHeaderTextStyle),
                ],
              ),
            );

            return Container(
              child: productoContent,
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
            Icons.center_focus_strong,
          ),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => BlocProvider<CarritoBloc>(
                      bloc: bloc,
                      child: BarcodeScannerPage(),
                    ),
              ),
            );
          }),
    );
  }
}
