import 'package:authshopapphttp/screens/cart/cart_screen.dart';
import 'package:authshopapphttp/screens/order/order_screen.dart';
import 'package:flutter/material.dart';

import 'package:authshopapphttp/screens/home/home_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("MyShop"),
          ),
          DrawerButton(
            name: "Shop",
            icon: Icons.shop,
            route: ProductsOverview.routeName,
          ),
          Divider(),
          DrawerButton(
            name: "Orders",
            icon: Icons.check,
            route: OrderScreen.routeName,
          ),
          Divider(),
          DrawerButton(
            name: "Cart",
            icon: Icons.shopping_cart,
            route: CartScreen.routeName,
          ),
          Divider(),
        ],
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final String route;
  const DrawerButton({
    Key? key,
    required this.name,
    required this.icon,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(route),
      child: ListTile(
        leading: Icon(icon),
        title: Text(name),
      ),
    );
  }
}
