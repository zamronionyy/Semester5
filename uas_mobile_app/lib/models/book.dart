// lib/models/book.dart
import 'loan_history.dart'; // Pastikan untuk mengimpor model LoanHistory
import 'review.dart'; // Pastikan untuk mengimpor model Review

class Book {
  late final String title;
  final String author;
  final String imageUrl;
  final String description;
  final int publicationYear;
  bool isFavorite;

  List<LoanHistory> loanHistory; // Tambahkan daftar riwayat peminjaman
  List<Review> reviews; // Tambahkan daftar review

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
    required this.publicationYear,
    this.isFavorite = false,
    List<LoanHistory>? loanHistory,
    List<Review>? reviews,
  })  : loanHistory = loanHistory ?? [],
        reviews = reviews ?? [];
}
