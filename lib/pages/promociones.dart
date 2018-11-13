import 'package:flutter/material.dart';
import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/blocs/promocion_catalogo_bloc.dart';
import 'package:fast_shop/models/promocion_card.dart';
import 'package:fast_shop/pages/detalle_promocion.dart';
import 'package:fast_shop/widgets/promociones_card_widget.dart';

class PromocionesPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final PromocionBloc promocionBloc =
        BlocProvider.of<PromocionBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          // Mostrar el GridView con la lista de todas las promociones en el catalogo de promociones
          child: StreamBuilder<List<Promocion>>(
              stream: promocionBloc.outPromocionList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Promocion>> snapshot) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildPromocionCard(
                        context, promocionBloc, index, snapshot.data);
                  },
                  itemCount: (snapshot.data == null ? 1 : snapshot.data.length),
                );
              }),
        ),
      ],
    );
  }

  Widget _buildPromocionCard(
      BuildContext context,
      PromocionBloc promocionBloc,
      int index,
      List<Promocion> promocionCards) {
    // Get the PromocionCard data
    final Promocion promocionCard =
        (promocionCards != null && promocionCards.length > index)
            ? promocionCards[index]
            : null;

    if (promocionCard == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return PromocionCardWidget(
      key: Key('promocion_${promocionCard.id}'),
      promocionCard: promocionCard,
      onPressed: () => print("Se presiono"),
    );
    // onPressed: () {
    //   Navigator
    //       .of(context)
    //       .push(MaterialPageRoute(builder: (BuildContext context) {
    //     return PromocionDetailsPage(
    //       data: promocionCard,
    //     );
    //   }));
    // });
  }
}
