import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fast_shop/api/fstshp_api.dart';
import 'package:fast_shop/models/promocion_card.dart';

class PromocionCardWidget extends StatefulWidget {
  PromocionCardWidget({
    Key key,
    @required this.promocionCard,
    @required this.onPressed,
    this.noHero: false,
  }) : super(key: key);

  final PromocionCard promocionCard;
  final VoidCallback onPressed;
  final bool noHero;

  @override
  PromocionCardWidgetState createState() => PromocionCardWidgetState();
}

class PromocionCardWidgetState extends State<PromocionCardWidget> {


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
  void dispose() {
    _disposeBloc();
    super.dispose();
  }



  void _disposeBloc() {
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      ClipRRect(
        clipper: _SquareClipper(),
        child: widget.noHero
               ? Image.network(api.imageBaseUrl + widget.promocionCard.rutaPoster,
              fit: BoxFit.cover)
               : Hero(
          child: Image.network(api.imageBaseUrl + widget.promocionCard.rutaPoster,
              fit: BoxFit.cover),
          tag: 'promocion_${widget.promocionCard.id}',
        ),
      ),
      Container(
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: _buildTextualInfo(widget.promocionCard),
      ),
    ];

    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: children,
        ),
      ),
    );
  }

  Widget _buildTextualInfo(PromocionCard promocionCard) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          promocionCard.descripcion,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4.0),
      ],
    );
  }
}

class _SquareClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    return new RRect.fromLTRBR(0.0, 0.0, size.width, size.width, Radius.circular(8.0));
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) {
    return false;
  }
}
