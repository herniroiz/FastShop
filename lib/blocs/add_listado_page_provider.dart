import 'package:fast_shop/models/categoria.dart';
import 'package:fast_shop/blocs/add_listado_page_bloc.dart';

import 'package:flutter/widgets.dart';

class AddListadoPageBlocProvider extends InheritedWidget {
  final AddListadoBloc listadoBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AddListadoBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AddListadoPageBlocProvider) as AddListadoPageBlocProvider)
          .listadoBloc;

  AddListadoPageBlocProvider({Key key, AddListadoBloc listadoBloc, Widget child})
      : this.listadoBloc = listadoBloc ?? AddListadoBloc(),
        super(child: child, key: key);
}