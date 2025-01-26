import 'package:flutter/material.dart';
import '../models/cart.dart';

class CheckoutView extends StatelessWidget {
  final List<Cart> cartItems;

  CheckoutView({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Proses checkout
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Checkout berhasil!')),
          );
          Navigator.pop(context); // Kembali ke halaman sebelumnya
        },
        child: Icon(Icons.check),
        tooltip: 'Checkout',
      ),
    );
  }
}
