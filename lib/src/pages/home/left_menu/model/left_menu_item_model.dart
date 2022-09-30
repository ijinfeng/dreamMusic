import 'package:flutter/material.dart';

class LeftMenuItemModel {
  String icon;
  String title;
  String? route;
  int index;

  LeftMenuItemModel({
    required this.icon,
    required this.title,
    required this.index,
    this.route
  });
}