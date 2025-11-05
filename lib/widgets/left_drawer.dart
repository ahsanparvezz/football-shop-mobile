// lib/widgets/left_drawer.dart
import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/product_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, 
            ),
            child: Column(
              children: [
                Text(
                  'Football Shop', // Judul diubah
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Your one-stop football gear shop!", // Deskripsi diubah
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          // Opsi Halaman Utama (Checklist 5)
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              // Navigasi ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopHomePage(
                    colorScheme: Theme.of(context).colorScheme,
                  ),
                ),
              );
            },
          ),
          // Opsi Tambah Produk (Checklist 5)
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Tambah Produk'),
            onTap: () {
              // Navigasi ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductFormPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}