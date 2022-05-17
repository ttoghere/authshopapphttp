import 'package:authshopapphttp/providers/cart.dart';
import 'package:flutter/material.dart';

class OrderProdItem {
  final String id;
  final double amount;
  final List<CartProdItem> products;
  final DateTime dateTime;
  OrderProdItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderProdItem> _orders = [];
  List<OrderProdItem> get orders {
    return [..._orders];
  }

  int get itemCount {
    return _orders.length;
  }

  void addOrder(
      {required List<CartProdItem> cartProducts, required double total}) {
    _orders.insert(
        0,
        OrderProdItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }
}
