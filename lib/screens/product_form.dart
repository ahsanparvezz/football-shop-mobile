// lib/screens/product_form.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk validasi angka
import 'package:football_shop/widgets/left_drawer.dart';

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
  String _category = "shoes"; // Nilai default
  bool _isFeatured = false;
  int _stock = 0; // Tambahan
  String _brand = ""; // Tambahan

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
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Produk')),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Nama Produk (Name) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    }
                    if (value.length < 3) {
                      return "Nama minimal 3 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Harga Produk (Price) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Harga (IDR)",
                    labelText: "Harga (IDR)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.tryParse(value!) ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Harga harus berupa angka!";
                    }
                    if (int.parse(value) <= 0) {
                      return "Harga harus lebih besar dari 0!";
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi Produk (Description) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Deskripsi Produk",
                    labelText: "Deskripsi Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    if (value.length < 10) {
                      return "Deskripsi minimal 10 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Kategori (Category) - DIPERBARUI ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  value: _category, // Nilai default
                  items: _categories.entries.map((entry) {
                    // map entries untuk mendapatkan key dan value
                    return DropdownMenuItem<String>(
                      value: entry.key, // 'jersey', 'shoes', dll.
                      child: Text(entry.value), // 'Jersey', 'Football Shoes', dll.
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === URL Thumbnail ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "URL Thumbnail",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "URL Thumbnail tidak boleh kosong!";
                    }
                    // Validasi URL Sederhana (sesuai peringatan)
                    if (!value.startsWith('http://') &&
                        !value.startsWith('https://')) {
                      return "URL tidak valid (harus diawali http:// atau https://)";
                    }
                    return null;
                  },
                ),
              ),

              // === Brand  ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Brand",
                    labelText: "Brand",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _brand = value!;
                    });
                  },
                  validator: (String? value) {
                    // Sesuai checklist "Tidak boleh kosong"
                    if (value == null || value.isEmpty) {
                      return "Brand tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Stock ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Stok Awal",
                    labelText: "Stok Awal",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (String? value) {
                    setState(() {
                      _stock = int.tryParse(value!) ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Stok tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Stok harus berupa angka!";
                    }
                    // Stok boleh 0, tapi tidak boleh negatif
                    if (int.parse(value) < 0) {
                      return "Stok tidak boleh negatif!";
                    }
                    return null;
                  },
                ),
              ),

              // === Is Featured ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              // === Tombol Simpan (Save) ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // 1. Tampilkan dialog dengan data yang MASIH ADA
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil disimpan!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Data ini sekarang akan terisi dengan benar
                                    Text('Nama: $_name'),
                                    Text('Harga: $_price'),
                                    Text('Deskripsi: $_description'),
                                    Text('Kategori: $_category'),
                                    Text('Thumbnail: $_thumbnail'),
                                    Text('Brand: $_brand'),
                                    Text('Stok: $_stock'),
                                    Text(
                                        'Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    // 2. TUTUP dialognya
                                    Navigator.pop(context);

                                    // 3. BARU reset form dan state SETELAH dialog ditutup
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _name = "";
                                      _price = 0;
                                      _description = "";
                                      _thumbnail = "";
                                      _category = "shoes"; // Reset ke default
                                      _isFeatured = false;
                                      _stock = 0;
                                      _brand = "";
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}