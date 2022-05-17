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

  double get totalAmount {
    var total = 0.0;
    _cart.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem({required String productId}) {
    _cart.remove(productId);
    notifyListeners();
  }

  void removeSingleItem({required String productId}) {
    if (!_cart.containsKey(productId)) {
      return;
    }
    if (_cart[productId]!.quantity > 1) {
      _cart.update(
          productId,
          (value) => CartProdItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price));
    } else {
      _cart.remove(productId);
    }
    notifyListeners();
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

  void clear() {
    _cart = {};
    notifyListeners();
  }
}
