import 'package:flutter/material.dart';
import 'package:fast_shop/models/promocion_card.dart';
import 'package:fast_shop/widgets/promociones_detalles_widget.dart';

class PromocionDetailsPage extends StatelessWidget {
  PromocionDetailsPage({
    Key key,
    this.data,
  }) : super(key: key);

  final Promocion data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.descripcion),
      ),
      body: PromocionDetailsWidget(
        promocionCard: data,
      ),
    );
  }
}
