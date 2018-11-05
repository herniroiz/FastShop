import 'package:flutter/material.dart';

import 'package:fast_shop/promocion/promocion_bloc.dart';
import 'package:fast_shop/promocion/promocion_proveedor.dart';
import 'package:fast_shop/common/models/promocion.dart';
// import 'package:fast_shop/promocion/promocion_lote.dart';
import 'package:fast_shop/grilla_promociones/promocion_cuadrado.dart';


class PromocionGrid extends StatelessWidget {
    static const _gridDelegate =
    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);

    PromocionGrid();

    Widget build(BuildContext context) {
    final promocionBloc = PromocionBloc(API());

    //TODO: Opcion para agregar una promocion al listado de compras... nunca se hara...

    return StreamBuilder(
      stream: promocionBloc.results,
      builder: (context, snapshot){
      GridView.builder(
            gridDelegate: _gridDelegate,
            itemCount: snapshot.data.length,
            itemBuilder: (context, indice) =>
                _createSquare(indice, snapshot.data, promocionBloc),
      );
      } 
    );
  }
    Widget _createSquare(int index, Promocion promocion, PromocionBloc promocionBloc) {

    // Display spinner if waiting for data.
    if (promocion == null) {
      return Center(child: CircularProgressIndicator());
    }

    // Display data.
    return Material(
      color: promocion.color,
      child: InkWell(
        onTap: () => print("algo sucedio"),
        child: Center(
            child: Text(promocion.nombre,
            style: TextStyle(
              color: Colors.black,
            ),
            ),
        ),
      ),
    );
  
}
  
}









// import 'package:flutter/material.dart';

// import 'package:fast_shop/promocion/promocion_bloc.dart';
// import 'package:fast_shop/promocion/promocion_proveedor.dart';
// import 'package:fast_shop/promocion/promocion_lote.dart';
// import 'package:fast_shop/grilla_promociones/promocion_cuadrado.dart';

// /// Muestra una grilla de promociones.
// class PromocionGrid extends StatelessWidget {

//   static const _gridDelegate =
//       const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);

//   PromocionGrid();

//   @override
//   Widget build(BuildContext context) {
//     final promocionBloc = ProveedorPromocion.of(context);
//     //TODO: Opcion para agregar una promocion al listado de compras... nunca se hara...
//     return StreamBuilder<LotePromocion>(
//       stream: promocionBloc.lote,
//       initialData: promocionBloc.lote.value,
//       builder: (context, snapshot) => GridView.builder(
//             gridDelegate: _gridDelegate,
//             itemCount: snapshot.data.endIndex + _loadingSpace,
//             itemBuilder: (context, indice) =>
//                 _createSquare(indice, snapshot.data, promocionBloc),
//           ),
//     );
//   }

//   /// Genera una promocion asignandole un [indice].
//   /// Ademas le envia un [indice] al [promocionBloc] para que pueda cargar mas datos (si tiene)
//   // Widget _createSquare(int indice, LotePromocion slice, PromocionBloc promocionBloc){
//     // Notificar a la promocion BLoC de el indice mas reciente que el framework 
//     // esta tratando de crear
//     promocionBloc.indice.add(indice);

//     // Traer los datos.
//     final promocion = slice.elementAt(indice);

//     // Mostrar un spinner mientras se esperan los datos.
//     if (promocion == null) {
//       return Center(child: CircularProgressIndicator());
//     }

//     // Mostrar los datos.
//     return PromocionCuadrado(
//       key: Key(promocion.id.toString()),
//       promocion: promocion,
//       itemsStream: promocionBloc,
//       onTap: () {
//         print("Se apreto la promocion #$promocion");
//       },
//     );
//   }
// }




