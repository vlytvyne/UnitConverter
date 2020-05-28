import 'package:flutter/material.dart';
import 'package:task_03_category_route/Category.dart';
import 'CategoryModel.dart';
import 'UnitConverterRoute.dart';

const appTitle = "Unit Converter";

class CategoriesRoute extends StatelessWidget {
  const CategoriesRoute();

  @override
  Widget build(BuildContext context) {
    final categoriesList = categories.map((category) => Category(category: category, onClick: () => onCategoryClick(context, category))).toList();
    final listView = ListView(children: categoriesList,);
    final appBar = AppBar(
      title: Text(appTitle, style: TextStyle(fontSize: 18),),
      elevation: 4,
	    backgroundColor: Colors.blue,
    );
    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }

  onCategoryClick(context, category) {
  	final route = MaterialPageRoute(builder: (context) => UnitConverterRoute(category: category));
  	Navigator.push(context, route);
  }

}
