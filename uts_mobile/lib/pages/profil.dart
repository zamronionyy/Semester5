import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.deepPurple, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Foto Profil
                Center(
                  child: CircleAvatar(
                    radius: 50, // Ukuran foto profil
                    backgroundImage: AssetImage('assets/image/profil.jpg'), // Ganti dengan URL foto profil
                  ),
                ),
                SizedBox(height: 20),

                // Deskripsi Nama Nasabah
                Text(
                  'Nama Nasabah',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                _buildProfileField('ACHMAD ZAMRONI'),

                SizedBox(height: 20),

                // Deskripsi Jenis Kelamin
                Text(
                  'Jenis Kelamin',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                _buildProfileField('Laki-laki'),

                SizedBox(height: 20),

                // Deskripsi Alamat
                Text(
                  'Alamat',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                _buildProfileField('Dsn. Pajaran, Peterongan, Jombang'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk membangun kolom profil
  Widget _buildProfileField(String value) {
    return Container(
      padding: EdgeInsets.all(15), // Menambah padding untuk kolom
      width: double.infinity, // Memperpanjang kolom agar memenuhi lebar
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.deepPurple, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
