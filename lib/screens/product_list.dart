// lib/screens/product_list.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_shop/models/product_entry.dart';
import 'package:football_shop/widgets/product_entry_card.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/screens/product_form.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<ProductEntry> products = [];
  bool isLoading = true;
  String currentFilter = 'my_products'; // 'all' or 'my_products'

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final request = context.read<CookieRequest>();

    setState(() {
      isLoading = true;
    });

    try {
      final response = await request.get(
        "http://localhost:8000/get-products-flutter/?filter=$currentFilter",
      );

      if (response['status'] == 'success') {
        List<ProductEntry> productList = (response['products'] as List)
            .map((data) => ProductEntry.fromJson(data))
            .toList();

        setState(() {
          products = productList;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${response['message']}")),
          );
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Connection error: $e")));
      }
    }
  }

  void _changeFilter(String newFilter) {
    setState(() {
      currentFilter = newFilter;
    });
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Netflix dark background
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF181818),
        elevation: 4,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentFilter,
                icon: const Icon(Icons.filter_list, color: Colors.redAccent),
                dropdownColor: const Color(0xFF181818),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _changeFilter(newValue);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'all',
                    child: Text(
                      'All Products',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'my_products',
                    child: Text(
                      'My Products',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            )
          : products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.inventory_2,
                          size: 64, color: Colors.white54),
                      const SizedBox(height: 16),
                      Text(
                        currentFilter == 'my_products'
                            ? 'You haven\'t added any products yet'
                            : 'No products available',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      if (currentFilter == 'my_products')
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductFormPage(),
                              ),
                            );
                          },
                          child: const Text('Add Your First Product'),
                        ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: Colors.redAccent,
                  backgroundColor: Colors.black,
                  onRefresh: fetchProducts,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ProductEntryCard(
                          product: product,
                          onTap: () {
                            // Keep same navigation logic
                          },
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductFormPage()),
          );
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

