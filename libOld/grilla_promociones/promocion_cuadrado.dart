// import 'dart:async';

// import 'package:fast_shop/promocion/promocion_lote.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import 'package:fast_shop/common/models/promocion.dart';
// import 'package:fast_shop/common/utils/is_dark.dart';


// /// In this version of [PromocionCuadrado], the widget must be a [StatefulWidget]
// /// because it has a [PromocionCuadradoBloc] that it needs to dispose of
// /// when it's no longer needed.
// class PromocionCuadrado extends StatefulWidget {
//   /// The product to be rendered.
//   final Promocion promocion;

//   /// The observable list of items in the cart. This is used to render
//   /// items that are already in the cart differently.
//   ///
//   /// This will be piped into this widget's [PromocionCuadradoBloc].
//   final Stream<List<LotePromocion>> itemsStream;

//   final GestureTapCallback onTap;

//   PromocionCuadrado({
//     Key key,
//     @required this.promocion,
//     @required this.itemsStream,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   _PromocionCuadradoState createState() => _PromocionCuadradoState();
// }

// class _PromocionCuadradoState extends State<PromocionCuadrado> {
//   /// The business logic component for the [PromocionCuadrado] widget.
//   ///
//   /// In our sample this might be overkill, but in a real app the widget will
//   /// get much more complicated (fetching images, availability, favorite status,
//   /// etc.).
//   // PromocionCuadradoBloc _bloc;

//   /// Because we're piping an output of one BLoC into an input of another,
//   /// we need to hold the subscription object in order to cancel it later.
//   StreamSubscription _subscription;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: widget.promocion.color,
//       child: InkWell(
//         onTap: widget.onTap,
//         child: Center(
//               child: StreamBuilder<bool>(
//               // stream: _bloc.isInCart,
//               // initialData: _bloc.isInCart.value,
//               builder: (context, snapshot) => _createText()),
//         ),
//       ),
//     );
//   }

//   /// Remember: widgets can change from above the [State] at the framework's
//   /// discretion. We need to make sure we always update the [State]
//   /// to reflect the [StatefulWidget].
//   ///
//   /// Here, we're disposing of the old [_bloc] and creating a new one.
//   // @override
//   // void didUpdateWidget(PromocionCuadrado oldWidget) {
//   //   super.didUpdateWidget(oldWidget);
//   //   _disposeBloc();
//   //   _createBloc();
//   // }

//   // @override
//   // void dispose() {
//   //   _disposeBloc();
//   //   super.dispose();
//   // }

//   /// Initialize business logic components that you will be disposing of in
//   /// [initState].
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _createBloc();
//   // }

//   /// Create the [PromocionCuadradoBloc] and pipe the stream of cart items
//   /// into its [PromocionCuadradoBloc.cartItems] input.
//   // void _createBloc() {
//   //   _bloc = PromocionCuadradoBloc(widget.promocion);
//   //   _subscription = widget.itemsStream.listen(_bloc.cartItems.add);
//   // }

//   /// A helper method that only builds the text of the [PromocionCuadrado].
//   ///
//   /// The text will be underlined when [isInCart] is `true`.
//   Widget _createText() {
//     return Text(
//       widget.promocion.nombre,
//       style: TextStyle(
//         color: isDark(widget.promocion.color) ? Colors.white : Colors.black,
//       ),
//     );
//   }

// }
