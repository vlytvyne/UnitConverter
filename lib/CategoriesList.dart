import 'package:flutter/material.dart';
import 'package:task_03_category_route/Category.dart';
import 'CategoryModel.dart';
import 'UnitConverter.dart';

const appTitle = "Unit Converter";

class CategoriesList extends StatelessWidget {
  const CategoriesList();

  @override
  Widget build(BuildContext context) {
    final categoriesList = categories.map((category) =>
		    Category(
				    category,
				    onClick: onCategoryClick(context, category)
		    )
    ).toList();
    return ListView(children: categoriesList);
  }

  onCategoryClick(context, category) {
  	final route = MaterialPageRoute(builder: (context) => UnitConverter(category));
  	Navigator.push(context, route);
  }

}
