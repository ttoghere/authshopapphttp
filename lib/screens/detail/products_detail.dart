import 'package:authshopapphttp/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsDetail extends StatelessWidget {
  static const routeName = "/pds";
  @override
  Widget build(BuildContext context) {
    var productId = ModalRoute.of(context)!.settings.arguments as String;
    var prodData =
        Provider.of<Products>(context, listen: false).itemFilter(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(prodData.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            prodData.imageUrl,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            prodData.title,
          ),
          SizedBox(
            height: 20,
          ),
          Text(prodData.description),
          SizedBox(
            height: 20,
          ),
          Text(prodData.price.toString()),
        ],
      ),
    );
  }
}
