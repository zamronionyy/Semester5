// lib/main.dart
import 'package:flutter/material.dart';
import 'package:uas_mobile_app/views/register_view.dart';
import 'views/login_view.dart';
import 'views/admin_view.dart';
import 'views/member_view.dart';
import 'views/reset_password_view.dart';
import 'views/book_list_view.dart'; // Import tampilan daftar buku

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/admin': (context) => AdminView(),
        '/member': (context) => MemberView(),
        '/register': (context) => RegisterView(),
        '/reset-password': (context) => ResetPasswordView(),
        '/book-list': (context) => BookListView(), // Rute untuk daftar buku
      },
    );
  }
}
