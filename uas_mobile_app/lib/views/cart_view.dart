import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartView extends StatelessWidget {
  final List<Cart> cartItems;

  CartView({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Keranjang kosong'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ListTile(
                  title: Text(cartItem.book.title),
                  subtitle: Text('Jumlah: ${cartItem.quantity}'),
                  trailing: Text('Total: ${cartItem.quantity}'),
                );
              },
            ),
    );
  }
}
