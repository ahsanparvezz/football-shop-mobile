// lib/screens/product_entry_list.dart

import 'package:flutter/material.dart';
import 'package:football_shop/models/product_entry.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/screens/product_detail.dart';
import 'package:football_shop/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchNews(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');

    // Decode response to json format
    var data = response;

    // Convert json data to NewsEntry objects
    List<ProductEntry> productList = [];
    for (var d in data) {
      if (d != null) {
        productList.add(ProductEntry.fromJson(d));
      }
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Products',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.9),
              Colors.black.withOpacity(0.95),
              Colors.black,
            ],
          ),
        ),
        child: FutureBuilder(
          future: fetchNews(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading Products...',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.store_mall_directory_outlined,
                        size: 80,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Products Available',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Be the first to add a product to TokoSofita!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Football Collection',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${snapshot.data!.length} products available',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Products List
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: ProductEntryCard(
                            product: snapshot.data![index],
                            onTap: () {
                              // Navigate to product detail page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: snapshot.data![index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}