import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileView extends StatelessWidget {
  final userData = GetStorage().read('user'); // Ambil data user dari storage

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ambil nama user dari data storage atau tampilkan "User" sebagai default
    final String userName = userData?['name'] ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar avatar atau ilustrasi
            Image.network(
              'https://example.com/avatar-placeholder.png', // URL gambar Anda
              height: 150,
            ),
            const SizedBox(height: 16),
            // Teks judul
            const Text(
              'Visit Me',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Deskripsi dengan nama user
            Text(
              'Hello.. My name $userName I\'m a backend & mobile developer near Bandung. Coding has become a perfect union of my two favourite passions and I love seeing the results of my efforts helping the users experience. I’m finding unique solutions to complex problems and I’m doing it all while making the worst puns you’ve never heard before.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            // Tombol logout
            ElevatedButton.icon(
              onPressed: () async {
                // Hapus data pengguna dari GetStorage
                await GetStorage().erase();

                // Arahkan pengguna kembali ke halaman login
                Get.offAllNamed('/login'); // Ganti '/login' dengan route ke halaman login Anda
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
