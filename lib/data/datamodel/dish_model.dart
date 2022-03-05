import './../../domain/all.dart';

class DishModel {
  final String id;
  final String restoid;
  final Map name;
  final Map description;
  final double price;
  final List<String> tags;
  final List<String> images;

  DishModel({
    required this.id,
    required this.restoid,
    required this.name,
    required this.description,
    required this.price,
    required this.tags,
    required this.images,
  });

  factory DishModel.fromfire(String key, Map value) {
    return DishModel(
      id: key,
      restoid: value["RestoId"],
      name: {
        englishlangstr: value["NameEnglish"],
        arabiclangstr: value["NameArabic"],
      },
      description: {
        englishlangstr: value["DescriptionEnglish"],
        arabiclangstr: value["DescriptionArabic"],
      },
      price: double.parse(value["Price"]),
      tags: value["Tags"] == null
          ? []
          : (value["Tags"] as List).map((e) => e.toString()).toList(),
      images: value["Images"] == null
          ? []
          : (value["Images"] as List).map((e) => e.toString()).toList(),
    );
  }
}
