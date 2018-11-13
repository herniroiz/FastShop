import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/blocs/carrito_bloc.dart';
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
