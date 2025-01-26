// lib/presenters/auth_presenter.dart
import '../models/user.dart';
import 'package:flutter/material.dart';

class AuthPresenter {
  // Simulasi pengguna
  final List<User> users = [
    User(username: 'admin', password: 'admin123', role: 'Admin'),
    User(username: 'member', password: 'member123', role: 'Member'),
  ];

  void login(User user, BuildContext context) {
    // Logika login
    User? foundUser = users.firstWhere(
      (u) => u.username == user.username && u.password == user.password,
      orElse: () => User(username: '', password: '', role: ''),
    );

    if (foundUser.username.isNotEmpty) {
      print('User  ${foundUser.username} logged in as ${foundUser.role}');
      // Navigasi berdasarkan role
      if (foundUser.role == 'Admin') {
        Navigator.pushNamed(context, '/admin');
      } else {
        Navigator.pushNamed(context, '/member');
      }
    } else {
      print('Login failed');
      // Tampilkan pesan kesalahan jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please check your credentials.')),
      );
    }
  }

  void register(User user) {
    // Logika registrasi
    print('User  ${user.username} registered with role ${user.role}');
  }
}
