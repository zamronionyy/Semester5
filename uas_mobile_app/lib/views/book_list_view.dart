import 'package:flutter/material.dart';
import 'package:uas_mobile_app/models/cart.dart';
import 'package:uas_mobile_app/views/checkout_view.dart';
import '../models/book.dart';
import '../models/review.dart'; // Pastikan untuk mengimpor model Review
import '../models/loan_history.dart'; // Pastikan untuk mengimpor model LoanHistory

class BookListView extends StatefulWidget {
  @override
  _BookListViewState createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  final List<Book> _books = [];
  final List<Book> _filteredBooks = [];
  final int _limit = 10; // Jumlah buku yang ditampilkan per halaman
  final List<Cart> _cartItems = []; // Daftar untuk menyimpan item keranjang
  int _page = 0; // Halaman saat ini
  bool _isLoading = false; // Status loading
  bool _hasMore = true; // Apakah masih ada buku yang bisa dimuat
  String _searchQuery = ''; // Query pencarian
  int? _selectedYear; // Tahun terbit yang dipilih untuk filter

  // Daftar gambar buku lokal
  final List<String> _bookImages = [
    'assets/images/book1.png',
    'assets/images/book2.png',
    'assets/images/book3.png',
    'assets/images/book4.png',
    'assets/images/book5.png',
    'assets/images/book6.png',
    'assets/images/book7.png',
    'assets/images/book8.png',
    'assets/images/book9.png',
    'assets/images/book10.png',
  ];

  // Daftar detail buku
  final List<String> _bookDescriptions = [
    'Judul : Kambing Jantan',
    'Judul : Marmut Merah Jambu',
    'Judul : Mariposa',
    'Judul : Dilan',
    'Judul : Milea',
    'Judul : Dua Garis Biru',
    'Judul : Algoritma Pemrograman',
    'Judul : Python Programer',
    'Judul : PHP Lengkap',
    'Judul : Javascript',
  ];

  final List<int> _publicationYears = [
    2021,
    2020,
    2019,
    2018,
    2017,
    2016,
    2015,
    2014,
    2013,
    2012
  ];

  @override
  void initState() {
    super.initState();
    _loadMoreBooks();
  }

  Future<void> _loadMoreBooks() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    // Simulasi delay untuk memuat data
    await Future.delayed(Duration(seconds: 2));

    // Tambahkan buku dummy dengan gambar lokal
    List<Book> newBooks = List.generate(_limit, (index) {
      if (_page * _limit + index < _bookImages.length) {
        return Book(
          title: 'Buku ${_page * _limit + index + 1}',
          author: 'Penulis ${_page * _limit + index + 1}',
          imageUrl: _bookImages[
              _page * _limit + index], // Menggunakan gambar dari daftar
          description: _bookDescriptions[
              _page * _limit + index], // Menambahkan deskripsi
          publicationYear: _publicationYears[
              _page * _limit + index], // Menambahkan tahun terbit
        );
      } else {
        return null; // Menghindari penambahan buku jika tidak ada gambar
      }
    }).where((book) => book != null).cast<Book>().toList(); // Menghapus null

    setState(() {
      _page++;
      _books.addAll(newBooks);
      _filteredBooks.addAll(newBooks); // Tambahkan ke daftar terfilter
      _isLoading = false;

      // Jika jumlah buku yang dimuat kurang dari limit, berarti tidak ada lagi buku
      if (newBooks.length < _limit) {
        _hasMore = false;
      }
    });
  }

  void _filterBooks() {
    setState(() {
      _filteredBooks.clear();
      _filteredBooks.addAll(_books.where((book) {
        final matchesSearchQuery =
            book.title.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesYear =
            _selectedYear == null || book.publicationYear == _selectedYear;
        return matchesSearchQuery && matchesYear;
      }));
    });
  }

  void _showImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
        );
      },
    );
  }

  void _showBookDetails(BuildContext context, Book book) {
    final TextEditingController _reviewController = TextEditingController();
    double _rating = 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(book.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(book.imageUrl, fit: BoxFit.cover),
              SizedBox(height: 8.0),
              Text('Penulis: ${book.author}'),
              Text('Tahun Terbit: ${book.publicationYear}'),
              SizedBox(height: 8.0),
              Text(book.description),
              SizedBox(height: 8.0),
              Text(
                book.isFavorite ? 'Favorit' : 'Tidak Favorit',
                style: TextStyle(
                  color: book.isFavorite ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text('Rating:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1.0; // Set rating
                      });
                    },
                  );
                }),
              ),
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: 'Tulis review...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8.0),
              Text('Reviews:'),
              ...book.reviews.map((review) {
                return ListTile(
                  title: Text(review.reviewerName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.comment),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 8.0),
              Text('Riwayat Peminjaman:'),
              ...book.loanHistory.map((loan) {
                return ListTile(
                  title: Text(loan.borrowerName),
                  subtitle: Text(
                      'Dipinjam: ${loan.loanDate.toLocal()} - Dikembalikan: ${loan.returnDate.toLocal()}'),
                );
              }).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_reviewController.text.isNotEmpty && _rating > 0) {
                  // Tambahkan review ke buku
                  book.reviews.add(Review(
                    reviewerName: 'Pengguna', // Ganti dengan nama pengguna
                    comment: _reviewController.text,
                    rating: _rating,
                  ));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Kirim'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Buku'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutView(cartItems: _cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari buku...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    _searchQuery = value;
                    _filterBooks();
                  },
                ),
                SizedBox(height: 8.0),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      hint: Text('Filter berdasarkan tahun terbit'),
                      value: _selectedYear,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedYear = newValue;
                          _filterBooks();
                        });
                      },
                      items: _publicationYears.map((year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!_isLoading &&
                    _hasMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  _loadMoreBooks();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: _filteredBooks.length +
                    (_hasMore
                        ? 1
                        : 0), // Tambahkan satu untuk indikator loading
                itemBuilder: (context, index) {
                  if (index == _filteredBooks.length) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Indikator loading
                  }
                  final book = _filteredBooks[index];
                  return ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    leading: GestureDetector(
                      onTap: () => _showImage(context, book.imageUrl),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Image.asset(
                          book.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(book.title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(book.author),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            book.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: book.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              book.isFavorite =
                                  !book.isFavorite; // Mengubah status favorit
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            setState(() {
                              // Tambahkan buku ke keranjang
                              final existingCartItem = _cartItems.firstWhere(
                                  (cartItem) =>
                                      cartItem.book.title == book.title,
                                  orElse: () => Cart(book: book, quantity: 0));
                              if (existingCartItem.quantity > 0) {
                                existingCartItem.quantity++;
                              } else {
                                _cartItems.add(Cart(book: book));
                              }
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${book.title} ditambahkan ke keranjang')),
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () => _showBookDetails(context, book),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
