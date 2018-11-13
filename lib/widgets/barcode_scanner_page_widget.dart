import 'package:fast_shop/blocs/barcode_page_bloc.dart';
import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class BarcodeScannerPage extends StatelessWidget {
  bool camState = true;
  @override
  Widget build(BuildContext context) {
    final BarcodePageBloc bloc = BlocProvider.of<BarcodePageBloc>(context);
    // final BarcodeBloc barcodeBloc = BlocProvider.of<BarcodeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Escanner"),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: camState
                      ? new Center(
                          child: QrCamera(
                            onError: (context, error) => Text(
                                  error.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                            qrCodeCallback: (code) {
                              bloc.inAddBarcode.add(int.parse(code));
                            },
                            child: Container(
                              alignment: Alignment(0.0, 0.9),
                              child: FloatingActionButton.extended(
                                onPressed: () {},
                                icon: Icon(Icons.keyboard),
                                label: Text("Lectura manual"),
                              ),
                            ),
                          ),
                        )
                      : new Center(child: new Text("Camera inactive"))),
              // StreamBuilder<int>(
              //   stream: bloc.outBarcode,
              //   initialData: 0,
              //       builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              //         return Text("QRCODE: ${snapshot.data.toString()}");
              //       },
              //     ),
            ],
          ),
        ),
      ),
    );
  }
}
