// lib/screens/product_form.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_shop/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Variabel state
  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "shoes";
  bool _isFeatured = false;
  int _stock = 0;
  String _brand = "";

  final Map<String, String> _categories = {
    'jersey': 'Jersey',
    'shoes': 'Football Shoes',
    'balls': 'Balls',
    'training': 'Training Equipment',
    'accessories': 'Accessories',
    'lifestyle': 'Lifestyle',
  };

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: const Color(0xFF141414), // Netflix dark background
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF141414),
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header text
                const Text(
                  'Product Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fill in the information below',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),

                // === Nama Produk ===
                _buildTextField(
                  label: "Product Name",
                  hint: "Enter product name",
                  onChanged: (value) => setState(() => _name = value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty!";
                    }
                    if (value.length < 3) {
                      return "Name must be at least 3 characters!";
                    }
                    return null;
                  },
                ),

                // === Harga Produk ===
                _buildTextField(
                  label: "Price (IDR)",
                  hint: "Enter price",
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => setState(() => _price = int.tryParse(value!) ?? 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Price cannot be empty!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Price must be a number!";
                    }
                    if (int.parse(value) <= 0) {
                      return "Price must be greater than 0!";
                    }
                    return null;
                  },
                ),

                // === Deskripsi Produk ===
                _buildTextField(
                  label: "Description",
                  hint: "Enter product description",
                  maxLines: 5,
                  onChanged: (value) => setState(() => _description = value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description cannot be empty!";
                    }
                    if (value.length < 10) {
                      return "Description must be at least 10 characters!";
                    }
                    return null;
                  },
                ),

                // === Kategori ===
                _buildLabel("Category"),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF404040)),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    dropdownColor: const Color(0xFF2D2D2D),
                    value: _category,
                    style: const TextStyle(color: Colors.white),
                    items: _categories.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // === URL Thumbnail ===
                _buildTextField(
                  label: "Thumbnail URL",
                  hint: "Enter image URL",
                  onChanged: (value) => setState(() => _thumbnail = value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Thumbnail URL cannot be empty!";
                    }
                    if (!value.startsWith('http://') && !value.startsWith('https://')) {
                      return "Invalid URL (must start with http:// or https://)";
                    }
                    return null;
                  },
                ),

                // === Brand ===
                _buildTextField(
                  label: "Brand",
                  hint: "Enter brand name",
                  onChanged: (value) => setState(() => _brand = value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Brand cannot be empty!";
                    }
                    return null;
                  },
                ),

                // === Stock ===
                _buildTextField(
                  label: "Stock",
                  hint: "Enter initial stock",
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => setState(() => _stock = int.tryParse(value!) ?? 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Stock cannot be empty!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Stock must be a number!";
                    }
                    if (int.parse(value) < 0) {
                      return "Stock cannot be negative!";
                    }
                    return null;
                  },
                ),

                // === Is Featured ===
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF404040)),
                  ),
                  child: SwitchListTile(
                    title: const Text(
                      "Mark as Featured Product",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: _isFeatured,
                    activeColor: const Color(0xFFE50914), // Netflix red
                    onChanged: (bool value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // === Tombol Simpan ===
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE50914), // Netflix red
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool shouldProceed = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFF2D2D2D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  title: const Text(
                                    'Confirm Save Product',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Product data to be saved:',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        _buildDialogRow('Name', _name),
                                        _buildDialogRow('Price', 'Rp $_price'),
                                        _buildDialogRow('Description', _description),
                                        _buildDialogRow('Category', _categories[_category]!),
                                        _buildDialogRow('Brand', _brand),
                                        _buildDialogRow('Stock', '$_stock'),
                                        _buildDialogRow('Featured', _isFeatured ? "Yes" : "No"),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.grey[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFE50914),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text('Save'),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;

                        if (shouldProceed) {
                          try {
                            final response = await request.postJson(
                              "http://localhost:8000/create-product-flutter/",
                              jsonEncode({
                                "name": _name,
                                "price": _price,
                                "description": _description,
                                "category": _category,
                                "thumbnail": _thumbnail,
                                "stock": _stock,
                                "brand": _brand,
                                "rating": 0.0,
                                "is_featured": _isFeatured,
                              }),
                            );

                            if (context.mounted) {
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text("Product saved successfully!"),
                                    backgroundColor: const Color(0xFF229954),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );

                                _formKey.currentState!.reset();
                                setState(() {
                                  _name = "";
                                  _price = 0;
                                  _description = "";
                                  _thumbnail = "";
                                  _category = "shoes";
                                  _isFeatured = false;
                                  _stock = 0;
                                  _brand = "";
                                });

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShopHomePage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Error: ${response['message']}"),
                                    backgroundColor: const Color(0xFFE50914),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Connection error: $e"),
                                  backgroundColor: const Color(0xFFE50914),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Save Product",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    required Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            maxLines: maxLines,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: const Color(0xFF2D2D2D),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF404040)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF404040)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE50914), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE50914)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE50914), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: onChanged,
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget _buildDialogRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}