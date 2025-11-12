// lib/widgets/shop_card.dart
import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart'; // Untuk model ShopItem
import 'package:football_shop/screens/product_form.dart'; // Untuk navigasi
import 'package:football_shop/screens/product_entry_list.dart';
import 'package:football_shop/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/screens/product_list.dart';

class ShopItemCard extends StatelessWidget {
  final ShopItem item;

  const ShopItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        // Logika navigasi untuk tombol "Create Product" (Checklist 3)
        onTap: () async {
          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );
          } else if (item.name == "All Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductEntryListPage(),
              ),
            );
          } else if (item.name == "My Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ProductListPage(), 
              ),
            );
          } else if (item.name == "Logout") {
            final response = await request.logout(
              "http://localhost:8000/auth/logout/",
            );
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("$message See you again, $uname."),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(message),
                  ),
                );
              }
            }
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("You pressed ${item.name}!"),
                ),
              );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _getCardGradient(item.name),
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: Colors.grey[800]!,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon dengan background circle
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon, 
                    color: Colors.white, 
                    size: 28.0
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                // Subtitle berdasarkan item
                Text(
                  _getSubtitle(item.name),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getCardGradient(String itemName) {
    switch (itemName) {
      case "All Products":
        return [
          Color(0xFF1E3A8A), // Dark blue
          Color(0xFF3B82F6), // Blue
        ];
      case "My Products":
        return [
          Color(0xFF059669), // Dark green
          Color(0xFF10B981), // Green
        ];
      case "Create Product":
        return [
          Color(0xFFDC2626), // Dark red
          Color(0xFFEF4444), // Red
        ];
      case "Logout":
        return [
          Color(0xFF6B7280), // Dark gray
          Color(0xFF9CA3AF), // Gray
        ];
      default:
        return [
          Color(0xFF2D2D2D),
          Color(0xFF404040),
        ];
    }
  }

  String _getSubtitle(String itemName) {
    switch (itemName) {
      case "All Products":
        return "Browse all items";
      case "My Products":
        return "Manage your items";
      case "Create Product":
        return "Add new product";
      case "Logout":
        return "Sign out of account";
      default:
        return "Explore feature";
    }
  }
}