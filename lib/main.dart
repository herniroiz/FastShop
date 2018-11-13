import 'dart:async';

import 'package:fast_shop/blocs/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/pages/home.dart';
import 'package:fast_shop/widgets/theme.dart';

Future<void> main() async {
//  debugPrintRebuildDirtyWidgets = true;
  return runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // Widget Raiz de la aplicacion
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FASTSHOP',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HomePageBloc>(
        bloc: HomePageBloc(),
        child: HomePage(title: 'FASTSHOP'),
      ),
      // routes: { CarritoPaginaBloc.routeName: (context) => CarritoPaginaBloc()},
    );
  }
}
