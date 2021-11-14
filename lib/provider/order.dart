import 'package:flutter/foundation.dart';
import '/provider/cart.dart';

class OrderItem {
  final String id;

  final List<CartItem> products;
  final double amount;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.dateTime,
    required this.amount,
    required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          dateTime: DateTime.now(),
          amount: total,
          products: cartProducts),
    );
    notifyListeners(); 
  }
}
