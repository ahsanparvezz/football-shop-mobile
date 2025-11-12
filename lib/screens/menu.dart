// lib/screens/menu.dart

import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/widgets/shop_card.dart';

class ShopHomePage extends StatelessWidget {
  ShopHomePage({super.key});

  final String nama = "Ahsan Parvez";
  final String npm = "2406496050";
  final String kelas = "E";

  final List<ShopItem> items = [
    ShopItem("All Products", Icons.store, Colors.blue),
    ShopItem("My Products", Icons.inventory, Colors.green),
    ShopItem("Create Product", Icons.add_circle, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE50914),
        title: const Text(
          'TokoSofita',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Info cards section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),
              const SizedBox(height: 16.0),

              // Welcome text
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Selamat datang di TokoSofita!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Grid of items (don't change these cards)
              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  return ShopItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      elevation: 4.0,
      shadowColor: Colors.red.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFE50914), width: 1),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFE50914),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(content, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}
