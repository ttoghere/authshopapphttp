import 'package:authshopapphttp/app_drawer.dart';
import 'package:authshopapphttp/providers/cart.dart';
import 'package:authshopapphttp/screens/cart/cart_screen.dart';
import 'package:authshopapphttp/screens/home/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:authshopapphttp/providers/product.dart';
import 'package:authshopapphttp/screens/home/widgets/product_item.dart';

enum FilterOptions {
  Favorites,
  ShowAll,
}

class ProductsOverview extends StatefulWidget {
  static const routeName = "/pos";
  ProductsOverview({Key? key}) : super(key: key);

  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _showOnlyFavs = false;
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: BgGradient(),
        title: Text("MyShop"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == FilterOptions.Favorites) {
                setState(() {
                  _showOnlyFavs = true;
                });
              } else if (value == FilterOptions.ShowAll) {
                setState(() {
                  _showOnlyFavs = false;
                });
              }
            },
            icon: Icon(Icons.more_vert_outlined),
            itemBuilder: ((context) => [
                  PopupMenuItem(
                    child: Text("Favorites"),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text("Show All"),
                    value: FilterOptions.ShowAll,
                  ),
                ]),
          ),
          Consumer<Cart>(
            builder: (context, value, child) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              value: cartProvider.itemCount.toString(),
              color: Colors.red[900]!,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.red[900]!,
            Colors.black,
            Colors.blue[900]!
          ], stops: [
            0.0,
            0.3,
            0.7,
            1.0,
          ]),
        ),
        child: ProductsGrid(
          showOnlyFavs: _showOnlyFavs,
        ),
      ),
    );
  }
}

class BgGradient extends StatelessWidget {
  const BgGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.red[900]!,
          Colors.black,
          Colors.blue[900]!
        ], stops: [
          0.0,
          0.3,
          0.7,
          1.0,
        ]),
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavs;
  const ProductsGrid({
    Key? key,
    required this.showOnlyFavs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);
    var productList = showOnlyFavs ? products.favoriteItems : products.items;
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final access = productList[index];
        return ChangeNotifierProvider.value(
          value: access,
          child: ProductItem(),
        );
      },
      padding: EdgeInsets.all(10),
    );
  }
}
