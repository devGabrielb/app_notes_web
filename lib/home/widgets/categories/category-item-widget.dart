import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/home/controllers/home-controller.dart';
import 'package:notes_app/home/widgets/categories/category-controller.dart';

class CategoryItem extends StatelessWidget {
  final String category;

  const CategoryItem({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryController _controller = GetIt.I<CategoryController>();
    final HomeController _homeController = GetIt.I<HomeController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: _controller.selectCategory.value == this.category
                ? Colors.blue
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () {
                _controller.changeCategory(this.category);
                _homeController.getNotes(category);
              },
              child: Container(
                width: 70,
                height: 30,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                        fontSize: 16,
                        color: _controller.selectCategory.value == this.category
                            ? Colors.white
                            : Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   width: 3,
          //   height: 3,
          //   decoration: BoxDecoration(
          //       color: Colors.red, borderRadius: BorderRadius.circular(50)),
          // )
        ],
      ),
    );
  }
}
