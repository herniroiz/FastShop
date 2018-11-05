// import 'package:fast_shop/carrito/carrito_pagina_bloc.dart';
// import 'package:fast_shop/common/widgets/carrito_boton.dart';
// import 'package:fast_shop/grilla_productos/product_grid.dart';
// import 'package:fast_shop/grilla_promociones/promocion_grid.dart';
import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/blocs/promocion_catalogo_bloc.dart';
import 'package:fast_shop/pages/promociones.dart';
import 'package:flutter/material.dart';
// import 'package:fast_shop/carrito/carrito_proveedor.dart';

// class FastshopHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: TabBar(
//             tabs: [
//             Tab(
//               text: "PROMOS",
//             ),
//             Tab(
//               text: "LISTADO",
//             ),
//             Tab(
//               text: "CARRITO",
//             ),
//             ],
//           ),
//           title: Text('FASTSHOP'),
//         ),
//         body: TabBarView(
//           children: [
//             // PromocionGrid(),
//             // PromocionesPage(),
//             _openList(context),
//             Icon(Icons.airline_seat_recline_extra),
//             Icon(Icons.airline_seat_recline_extra),
//           ],
//         ),
//       ),
//     );
//   }
  
//     _openList(BuildContext context) {
//       Navigator
//       .of(context)
//       .push(MaterialPageRoute(builder: (BuildContext context) {
//         return BlocProvider<PromocionCatalogoBloc>(
//         bloc: PromocionCatalogoBloc(),
//         child: PromocionesPage(),
//       );
//       }));
//     }
  

//   // _openPromocion(BuildContext context) {
//   //   Navigator
//   //       .of(context)
//   //       .push(MaterialPageRoute(builder: (BuildContext context) {
//   //     return BlocProvider<MovieCatalogBloc>(
//   //       bloc: MovieCatalogBloc(),
//   //       child: ListOnePage(),
//   //     );
//   //   }));
//   // }

// }





// import 'package:flutter/material.dart';
// import 'package:movies_streams/blocs/bloc_provider.dart';
// import 'package:movies_streams/blocs/movie_catalog_bloc.dart';
// import 'package:movies_streams/pages/list.dart';
// import 'package:movies_streams/pages/list_one_page.dart';
// import 'package:movies_streams/widgets/favorite_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Movies')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // RaisedButton(
            //   child: Text('Movies List'),
            //   onPressed: () {
        //          return Navigator
        // .of(context)
        // .push(MaterialPageRoute(builder: (BuildContext context) {
       BlocProvider<PromocionCatalogoBloc>(
        bloc: PromocionCatalogoBloc(),
        child: PromocionesPage(),
      ),
    // }));
            //   },
            // ),
          ],
        ),
      ),
    );
  }


  void _openPage(BuildContext context) {
    Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider<PromocionCatalogoBloc>(
        bloc: PromocionCatalogoBloc(),
        child: PromocionesPage(),
      );
    }));
  }

  // void _openOnePage(BuildContext context) {
  //   Navigator
  //       .of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     return BlocProvider<MovieCatalogBloc>(
  //       bloc: MovieCatalogBloc(),
  //       child: ListOnePage(),
  //     );
  //   }));
  // }
}
