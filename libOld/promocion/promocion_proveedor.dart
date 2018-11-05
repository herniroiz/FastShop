import 'package:fast_shop/promocion/promocion_bloc.dart';
import 'package:fast_shop/common/models/promocion.dart';
import 'package:flutter/widgets.dart';

/// Equivalente a  [ProveedorCarrito], pero para [PromocionBloc].
class ProveedorPromocion extends InheritedWidget {
  final PromocionBloc promocionBloc;

  // ProveedorPromocion({
  //   Key key,
  //   @required PromocionBloc promocion,
  //   Widget child,
  // })  : assert(promocion != null),
  //       promocionBloc = promocion,
  //       super(key: key, child: child);

   ProveedorPromocion({Key key, PromocionBloc promocionBloc, Widget child})
      : this.promocionBloc = promocionBloc ?? PromocionBloc(API()),
        super(child: child, key: key);


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  static PromocionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ProveedorPromocion) as ProveedorPromocion)
          .promocionBloc;
}