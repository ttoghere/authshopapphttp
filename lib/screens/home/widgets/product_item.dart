import 'package:authshopapphttp/providers/cart.dart';
import 'package:authshopapphttp/providers/product.dart';
import 'package:authshopapphttp/screens/detail/products_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productBp = Provider.of<Product>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductsDetail.routeName, arguments: productBp.id);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              productBp.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (context, pP, child) => IconButton(
              icon: Icon(
                Icons.favorite,
                color: pP.isFavorite ? Colors.orange[900] : Colors.white,
              ),
              onPressed: () {
                pP.toggleFav();
              },
            ),
          ),
          trailing: Consumer<Cart>(
            builder: (context, cart, child) => IconButton(
              onPressed: () {
                cart.addItem(
                  productId: productBp.id,
                  price: productBp.price,
                  title: productBp.title,
                );
              },
              icon: Icon(Icons.shopping_cart_outlined),
            ),
          ),
          backgroundColor: Colors.black54,
          title: Text(
            productBp.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
