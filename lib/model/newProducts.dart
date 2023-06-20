import 'dart:convert';

NoteModel? noteModelFromJson(String str) =>
    NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel? data) => json.encode(data!.toJson());

class NoteModel {
  NoteModel({
    this.products,
    this.count,
  });

  List<Product?>? products;
  int? count;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        products: json["products"] == null
            ? []
            : List<Product?>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x!.toJson())),
        "count": count,
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.sku,
    this.description,
    this.price,
    this.count,
    this.createdAt,
    required this.image
  });

  int? id;
  String? name;
  String? sku;
  String? description;
  int? price;
  int? count;
  String image;
  DateTime? createdAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        description: json["description"],
        price: json["price"],
        count: json["count"],
        image: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "description": description,
        "price": price,
        "count": count,
        "image_url": image,
        "created_at": createdAt?.toIso8601String(),
      };
}
