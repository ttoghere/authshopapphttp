import 'package:authshopapphttp/providers/cart.dart';
import 'package:authshopapphttp/providers/product.dart';
import 'package:authshopapphttp/screens/detail/products_detail.dart';
import 'package:authshopapphttp/screens/home/home_screen.dart';
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
      ],
      child: MaterialApp(
        title: 'Material App',
        home: ProductsOverview(),
        routes: {
          ProductsDetail.routeName: (context) => ProductsDetail(),
        },
      ),
    );
  }
}
