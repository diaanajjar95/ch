// To parse this JSON data, do
//
//     final menuItem = menuItemFromJson(jsonString);

import 'dart:convert';

List<MenuItem> menuItemFromJson(String str) =>
    List<MenuItem>.from(json.decode(str).map((x) => MenuItem.fromJson(x)));

String menuItemToJson(List<MenuItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuItem {
  int id;
  String name;
  int categoryId;
  String imgUrl;
  String subTitle;
  double rate;
  dynamic description;
  List<MenuItemSize> menuItemSizes;

  MenuItem({
    this.id,
    this.name,
    this.categoryId,
    this.imgUrl,
    this.subTitle,
    this.rate,
    this.description,
    this.menuItemSizes,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json["Id"],
        name: json["Name"],
        categoryId: json["CategoryId"],
        imgUrl: json["ImgURL"],
        subTitle: json["SubTitle"],
        rate: json["Rate"].toDouble(),
        description: json["Description"],
        menuItemSizes: List<MenuItemSize>.from(
            json["MenuItemSizes"].map((x) => MenuItemSize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "CategoryId": categoryId,
        "ImgURL": imgUrl,
        "SubTitle": subTitle,
        "Rate": rate,
        "Description": description,
        "MenuItemSizes":
            List<dynamic>.from(menuItemSizes.map((x) => x.toJson())),
      };
}

class MenuItemSize {
  int id;
  int menuItemId;
  int pointPrice;
  double waletPrice;
  int offerPoint;
  String name;

  MenuItemSize({
    this.id,
    this.menuItemId,
    this.pointPrice,
    this.waletPrice,
    this.offerPoint,
    this.name,
  });

  factory MenuItemSize.fromJson(Map<String, dynamic> json) => MenuItemSize(
        id: json["Id"],
        menuItemId: json["MenuItemId"],
        pointPrice: json["PointPrice"],
        waletPrice: json["WaletPrice"].toDouble(),
        offerPoint: json["OfferPoint"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "MenuItemId": menuItemId,
        "PointPrice": pointPrice,
        "WaletPrice": waletPrice,
        "OfferPoint": offerPoint,
        "Name": name,
      };
}
