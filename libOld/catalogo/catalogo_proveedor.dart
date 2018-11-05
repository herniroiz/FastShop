import 'package:fast_shop/catalogo/catalogo_bloc.dart';
import 'package:flutter/widgets.dart';

/// Equivalente a  [ProveedorCarrito], pero para [CatalogBloc].
class ProveedorCatalogo extends InheritedWidget {
  final CatalogoBloc catalogoBloc;

  ProveedorCatalogo({
    Key key,
    @required CatalogoBloc catalogo,
    Widget child,
  })  : assert(catalogo != null),
        catalogoBloc = catalogo,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CatalogoBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ProveedorCatalogo) as ProveedorCatalogo)
          .catalogoBloc;
}
