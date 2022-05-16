import 'package:flutter/material.dart';

class CartProdItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartProdItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartProdItem> _cart = {};
  Map<String, CartProdItem> get cart {
    return {..._cart};
  }

  int get itemCount {
    return _cart.length;
  }

  void addItem(
      {required String productId,
      required double price,
      required String title}) {
    if (_cart.containsKey(productId)) {
      _cart.update(
          productId,
          (value) => CartProdItem(
              id: value.id,
              title: title,
              quantity: value.quantity + 1,
              price: value.price));
    } else {
      _cart.putIfAbsent(
        productId,
        () => CartProdItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: 1,
            price: price),
      );
    }
    notifyListeners();
  }
}