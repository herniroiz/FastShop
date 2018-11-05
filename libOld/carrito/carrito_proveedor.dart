import 'package:flutter/widgets.dart';
import 'package:fast_shop/carrito/carrito_bloc.dart';

/// Este es un InheritedWidget que envuelve a [CarritoBloc]. pensar a esta clase como 
/// un Scoped Model (modelo que tiene en la mirilla) para esa clase especifica.

class ProveedorCarrito extends InheritedWidget {
  final CarritoBloc carritoBloc;
  
  ProveedorCarrito({
    Key key,
    CarritoBloc carritoBloc,
    Widget child,
  })  : carritoBloc = carritoBloc ?? CarritoBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CarritoBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ProveedorCarrito) as ProveedorCarrito)
          .carritoBloc;
}
