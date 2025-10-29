// menu.dart
import 'package:flutter/material.dart';

// 1. Ganti nama widget utama menjadi ShopHomePage
class ShopHomePage extends StatelessWidget {
  // Konstruktor ini disamakan dengan tutorial
  ShopHomePage({super.key, required ColorScheme colorScheme});

  // Info ini tetap ada agar sesuai dengan struktur tutorial
  final String nama = "Ahsan Parvez"; //nama
  final String npm = "2406496050"; //npm
  final String kelas = "E"; //kelas

  // 2. Buat list item baru sesuai permintaan
  final List<ShopItem> items = [
    ShopItem("All Products", Icons.store, Colors.blue),
    ShopItem("My Products", Icons.inventory, Colors.green),
    ShopItem("Create Product", Icons.add_circle, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Ganti judul AppBar
        title: const Text(
          'Football Shop',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Struktur body ini sama dengan tutorial Anda
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row untuk InfoCard (NPM, Nama, Kelas) sama seperti tutorial
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            Center(
              child: Column(
                children: [
                  // Ganti teks sambutan
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di Football Shop',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView ini sama, tapi sekarang menggunakan ShopItemCard
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    // Mapping list item baru ke widget card baru
                    children: items.map((ShopItem item) {
                      return ShopItemCard(item); // Gunakan ShopItemCard
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget InfoCard ini disalin utuh dari tutorial Anda
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

// 3. Buat data model baru, tambahkan 'color'
class ShopItem {
  final String name;
  final IconData icon;
  final Color color; // Tambahan properti warna

  ShopItem(this.name, this.icon, this.color);
}

// 4. Buat widget card baru (menggantikan ItemCard)
class ShopItemCard extends StatelessWidget {
  final ShopItem item;

  const ShopItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // 5. Gunakan warna spesifik dari item, BUKAN dari tema
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // 6. Logika onTap ini sudah benar
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                // Pesan SnackBar akan otomatis sesuai nama item
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}