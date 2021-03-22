import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryController {
  final listCategory = ["All", "Home", "Work", "Personal"];
  final selectCategory = ValueNotifier<String>("All");

  void changeCategory(String category) {
    selectCategory.value = category;
  }
}
