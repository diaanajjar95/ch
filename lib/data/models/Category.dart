// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int id;
  String name;
  String subTitle;
  String imgUrl;
  String description;

  Category({
    this.id,
    this.name,
    this.subTitle,
    this.imgUrl,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["Id"],
        name: json["Name"],
        subTitle: json["SubTitle"],
        imgUrl: json["ImgURL"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "SubTitle": subTitle,
        "ImgURL": imgUrl,
        "Description": description,
      };
}
