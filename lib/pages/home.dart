import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/blocs/carrito_bloc.dart';
import 'package:fast_shop/blocs/home_page_bloc.dart';
import 'package:fast_shop/blocs/listas_page_bloc.dart';
import 'package:fast_shop/blocs/promocion_catalogo_bloc.dart';
import 'package:fast_shop/pages/carrito.dart';
import 'package:fast_shop/pages/lista.dart';
import 'package:fast_shop/pages/promociones.dart';
import 'package:flutter/material.dart';

enum TabItem { Promociones, Listado, Scanner }

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc _bloc;

  final _widgetOptions = [
    BlocProvider<ListaBloc>(
      bloc: ListaBloc(),
      child: ListadoPage(),
    ),
    BlocProvider<PromocionBloc>(
      bloc: PromocionBloc(),
      child: PromocionesPage(),
    ),
    BlocProvider<CarritoBloc>(
      bloc: CarritoBloc(),
      child: CarritoPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<HomePageBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder<int>(
              initialData: 0,
              stream: _bloc.pageIndexStream,
              builder: (context, snapshot) {
                return Scaffold(
                  appBar: AppBar(title: Text('FASTSHOP')),
                  body: _widgetOptions.elementAt(snapshot.data),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: snapshot.data,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        title: Text("LISTADO"),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.local_offer),
                        title: Text("PROMOS"),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart),
                        title: Text("CARRITO"),
                      ),
                    ],
                    onTap: _onItemSelected,
                  ),
                );
              }),
        ),
      ],
    );
  }

  void _onItemSelected(int index) => _bloc.pageIndex.add(index);
  @override
  void dispose() {
    super.dispose();
  }
}

// class AppState extends State<HomePage> {

//   TabItem currentTab = TabItem.Promociones;

//   void _selectTab(TabItem tabItem) {
//     setState(() {
//       currentTab = tabItem;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(

//       appBar: AppBar(title: Text('FASTSHOP'),
//       bottom: TabBar(
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
//       ),
//       body: _promociones(),
//       ),
//     );
//   }

//   Widget _promociones() {
//     return BlocProvider<PromocionCatalogoBloc>(
//       bloc: PromocionCatalogoBloc(),
//       child: PromocionesPage()
//       );
//   }
// }
