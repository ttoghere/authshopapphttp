import 'package:authshopapphttp/providers/cart.dart';
import 'package:authshopapphttp/providers/order.dart';
import 'package:authshopapphttp/providers/product.dart';
import 'package:authshopapphttp/screens/cart/cart_screen.dart';
import 'package:authshopapphttp/screens/detail/products_detail.dart';
import 'package:authshopapphttp/screens/home/home_screen.dart';
import 'package:authshopapphttp/screens/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Order()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: ProductsOverview(),
        routes: {
          ProductsDetail.routeName: (context) => ProductsDetail(),
          CartScreen.routeName: (context) => CartScreen(),
          ProductsOverview.routeName: (context) => ProductsOverview(),
          OrderScreen.routeName: (context) => OrderScreen()
        },
      ),
    );
  }
}
