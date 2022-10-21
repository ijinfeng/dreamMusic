import 'package:flutter/material.dart';


enum LeftMenuItemName {
  find,
  personal,
  mylike,
  mycollection,
  mydownload,
  setting,
  test
}

class LeftMenuItemModel {
  String icon;
  String title;
  String? route;
  LeftMenuItemName name;

  LeftMenuItemModel({
    required this.icon,
    required this.title,
    required this.name,
    this.route
  });
}