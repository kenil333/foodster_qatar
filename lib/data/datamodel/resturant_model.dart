import './../../domain/all.dart';

class ResturantModel {
  final String id;
  final int number;
  final Map name;
  final Map type;
  final Map timming;
  final Map description;
  final Map location;
  final double latitude;
  final double longitude;
  final List<String> tags;
  final List<String> profilepic;
  final List<String> restopic;

  ResturantModel({
    required this.id,
    required this.number,
    required this.name,
    required this.type,
    required this.timming,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.tags,
    required this.profilepic,
    required this.restopic,
  });

  factory ResturantModel.formfire(String key, Map value) {
    return ResturantModel(
      id: key,
      number: value["Number"],
      name: {
        englishlangstr: value["NameEnglish"],
        arabiclangstr: value["NameArabic"],
      },
      type: {
        englishlangstr: value["TypeEnglish"],
        arabiclangstr: value["TypeArabic"],
      },
      latitude: double.parse(value["Latitude"]),
      longitude: double.parse(value["Longitude"]),
      timming: {
        englishlangstr: value["TimmingEnglish"],
        arabiclangstr: value["TimmingArabic"],
      },
      description: {
        englishlangstr: value["DescriptionEnglish"],
        arabiclangstr: value["DescriptionArabic"],
      },
      location: {
        englishlangstr: value["LocationEnglish"],
        arabiclangstr: value["LocationArabic"],
      },
      tags: value["Tags"] == null
          ? []
          : (value["Tags"] as List).map((e) => e.toString()).toList(),
      profilepic: value["ProfileImage"] == null
          ? []
          : (value["ProfileImage"] as List).map((e) => e.toString()).toList(),
      restopic: value["ResturantImage"] == null
          ? []
          : (value["ResturantImage"] as List).map((e) => e.toString()).toList(),
    );
  }
}
