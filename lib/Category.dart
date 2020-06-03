import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_03_category_route/CategoryModel.dart';

const _widgetHeight = 100.0;
const _iconSize = 40.0;

class Category extends StatelessWidget {

	final CategoryModel category;
  final VoidCallback onClick;

  const Category(
			this.category,
      {Key key,
      this.onClick})
      : assert(category != null),
			  super(key: key);

  @override
  build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _widgetHeight,
        child: InkWell(
          highlightColor: category.color,
          splashColor: category.color,
          onTap: onClick,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: buildRow(context),
          ),
        ),
      ),
    );
  }

  Row buildRow(context) {
  	final iconWidget =
	  Padding(
		  padding: EdgeInsets.all(16),
		  child: Image.asset(category.iconLocation),
	  );
  	final textWidget = Text(category.name, style: Theme.of(context).textTheme.headline,);
    return Row(children: [iconWidget, textWidget],);
  }
}
