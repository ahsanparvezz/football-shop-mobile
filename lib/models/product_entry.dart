// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

// lib/models/product_entry.dart

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => 
    List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String id;
    String name;
    int price;
    String description;
    double rating;
    int stock;
    String category;
    String thumbnail;
    int views;
    String createdAt;
    int? userId;  // nullable
    bool isFeatured;

    ProductEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.rating,
        required this.stock,
        required this.category,
        required this.thumbnail,
        required this.views,
        required this.createdAt,
        this.userId,  // 👈 NULLABLE
        required this.isFeatured,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"]?.toString() ?? "",  // 👈 SAFE PARSING
        name: json["name"] ?? "",
        price: json["price"] ?? 0,
        description: json["description"] ?? "",
        rating: (json["rating"] ?? 0).toDouble(),
        stock: json["stock"] ?? 0,
        category: json["category"] ?? "shoes",  // 👈 DEFAULT VALUE
        thumbnail: json["thumbnail"] ?? "",
        views: json["views"] ?? 0,
        createdAt: json["created_at"] ?? "",
        userId: json["user_id"],  // 👈 BISA NULL
        isFeatured: json["is_featured"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "rating": rating,
        "stock": stock,
        "category": category,
        "thumbnail": thumbnail,
        "views": views,
        "created_at": createdAt,
        "user_id": userId,
        "is_featured": isFeatured,
    };
}
