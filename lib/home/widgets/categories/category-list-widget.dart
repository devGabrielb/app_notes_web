import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/home/widgets/categories/category-controller.dart';
import 'package:notes_app/home/widgets/categories/category-item-widget.dart';

class CategoryListWidget extends StatefulWidget {
  final Size size;

  const CategoryListWidget({Key key, this.size}) : super(key: key);
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  CategoryController _controller = GetIt.I<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _controller.selectCategory,
        builder: (_, value, ___) {
          return Container(
            child: ListView.builder(
              itemCount: _controller.listCategory.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: CategoryItem(
                    category: _controller.listCategory[index],
                  ),
                );
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          );
        });
  }
}
