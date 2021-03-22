import 'package:get_it/get_it.dart';
import 'package:notes_app/home/controllers/home-controller.dart';
import 'package:notes_app/home/widgets/categories/category-controller.dart';

GetIt locator = GetIt.I;
void setupLocator() {
  locator.registerSingleton<CategoryController>(CategoryController());
  locator.registerSingleton<HomeController>(HomeController());
}
