import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/blocs/promocion_catalogo_bloc.dart';
import 'package:fast_shop/pages/promociones.dart';
import 'package:flutter/material.dart';

enum TabItem { Promociones, Listado, Scanner }

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<HomePage> {

  TabItem currentTab = TabItem.Promociones;

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

      appBar: AppBar(title: Text('FASTSHOP'),
      bottom: TabBar(
            tabs: [
            Tab(
              text: "PROMOS",
            ),
            Tab(
              text: "LISTADO",
            ),
            Tab(
              text: "CARRITO",
            ),
            ],
          ),
      ),
      body: _buildBody(),

      ),
    );
  }
  
  Widget _buildBody() {
    return BlocProvider<PromocionCatalogoBloc>(
      bloc: PromocionCatalogoBloc(),
      child: PromocionesPage()
      );
  }
}