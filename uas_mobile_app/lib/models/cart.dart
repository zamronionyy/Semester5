import 'book.dart';

class Cart {
  final Book book; // Mengacu pada model Book
  int quantity; // Jumlah buku dalam keranjang

  Cart({required this.book, this.quantity = 1}); // Konstruktor
}
