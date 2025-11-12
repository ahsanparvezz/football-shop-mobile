// lib/widgets/left_drawer.dart

import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/product_form.dart';
import 'package:football_shop/screens/product_entry_list.dart';
import 'package:football_shop/screens/product_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          // Netflix-style Drawer Header
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  Colors.red.withOpacity(0.3),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[800]!,
                  width: 1.0,
                ),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TokoSofita',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Your one-stop football gear shop!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Icon(
                  Icons.sports_soccer,
                  size: 40,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          
          // Navigation Items
          _buildDrawerSection(
            title: "MAIN",
            children: [
              // Home Page
              _buildDrawerItem(
                icon: Icons.home_outlined,
                title: 'Home',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShopHomePage()),
                  );
                },
              ),
            ],
          ),
          
          _buildDrawerSection(
            title: "PRODUCTS",
            children: [
              // All Products
              _buildDrawerItem(
                icon: Icons.store_outlined,
                title: 'All Products',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductEntryListPage(),
                    ),
                  );
                },
              ),
              
              // My Products
              _buildDrawerItem(
                icon: Icons.inventory_2_outlined,
                title: 'My Products',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductListPage(),
                    ),
                  );
                },
              ),
              
              // Add Product
              _buildDrawerItem(
                icon: Icons.add_circle_outline,
                title: 'Add Product',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductFormPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          
          // Footer Section
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[800]!),
            ),
            child: Column(
              children: [
                Text(
                  'Premium Football Gear',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Experience the best collection of football merchandise',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method untuk membuat section header
  Widget _buildDrawerSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        ...children,
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 1,
          color: Colors.grey[800],
        ),
      ],
    );
  }

  // Helper method untuk membuat drawer item
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[300],
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      minLeadingWidth: 0,
      tileColor: Colors.transparent,
      hoverColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}