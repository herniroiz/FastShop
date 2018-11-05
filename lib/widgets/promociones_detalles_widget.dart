import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fast_shop/api/fstshp_api.dart';
import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/promocion_card.dart';

class PromocionDetailsWidget extends StatefulWidget {
  PromocionDetailsWidget({
    Key key,
    this.promocionCard,
    this.boxFit: BoxFit.cover,
  }) : super(key: key);

  final PromocionCard promocionCard;
  final BoxFit boxFit;

  @override
  _PromocionDetailsWidgetState createState() => _PromocionDetailsWidgetState();
}

class _PromocionDetailsWidgetState extends State<PromocionDetailsWidget> {

  ///
  /// In order to determine whether this particular Movie is
  /// part of the list of favorites, we need to inject the stream
  /// that gives us the list of all favorites to THIS instance
  /// of the BLoC
  ///
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

  }

  ///
  /// As Widgets can be changed by the framework at any time,
  /// we need to make sure that if this happens, we keep on
  /// listening to the stream that notifies us about favorites
  ///
  @override
  void didUpdateWidget(PromocionDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeBloc();

  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }


  void _disposeBloc() {
    _subscription.cancel();

  }

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Hero(
                  child: Image.network(
                    api.imageBaseUrl + widget.promocionCard.rutaPoster,
                    fit: widget.boxFit,
                  ),
                  tag: 'promocion_${widget.promocionCard.id}',
                ),
              ],
            ),
          ),
          SizedBox(height: 4.0),
          Divider(),
          Container(
            padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 8.0),
            child: Text(widget.promocionCard.descripcion),
          ),
        ],
      ),
    );
  }
}
