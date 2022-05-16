import 'package:authshopapphttp/providers/product.dart';
import 'package:authshopapphttp/screens/home/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  ShowAll,
}

class ProductsOverview extends StatelessWidget {
  ProductsOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: BgGradient(),
        title: Text("MyShop"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == FilterOptions.Favorites) {
                productsProvider.favStatus();
              } else if (value == FilterOptions.ShowAll) {
                productsProvider.showAllStatus();
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
          )
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
        child: ProductsGrid(),
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
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);
    var productList = products.items;
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
