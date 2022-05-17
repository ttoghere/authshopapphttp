import 'package:authshopapphttp/providers/cart.dart';
import 'package:authshopapphttp/providers/order.dart';
import 'package:authshopapphttp/screens/cart/widgets/cart_item.dart';
import 'package:authshopapphttp/screens/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    var cartP = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      "\$${cartP.totalAmount.toStringAsFixed(2)}",
                    ),
                    backgroundColor: Colors.red[900],
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Order>(context, listen: false).addOrder(
                        cartProducts: cartP.cart.values.toList(),
                        total: cartP.totalAmount,
                      );
                      cartP.clear();
                      Navigator.of(context).pushNamed(OrderScreen.routeName);
                    },
                    child: Text("Order Now"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cartP.itemCount,
                itemBuilder: (context, index) {
                  var access = cartP.cart.values.toList()[index];
                  return CartItem(
                    productId: cartP.cart.keys.toList()[index],
                    id: access.id,
                    price: access.price,
                    quantity: access.quantity,
                    title: access.title,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
