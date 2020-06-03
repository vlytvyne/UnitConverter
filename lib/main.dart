// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// You can read about packages here: https://flutter.io/using-packages/
import 'package:flutter/material.dart';
import 'package:task_03_category_route/CategoriesList.dart';
import 'backdrop.dart';
import 'package:task_03_category_route/UnitConverter.dart';
import 'Category.dart';
import 'CategoryModel.dart';

void main() {
	runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Unit Converter',
			home: _UnitConverterRoute()
		);
	}
}

class _UnitConverterRoute extends StatefulWidget {

	@override
	State<StatefulWidget> createState() => _UnitConverterRouteState();

}

class _UnitConverterRouteState extends State<_UnitConverterRoute> {

	int selectedCategoryPosition = 0;
	bool frontIsExpanded = true;

	final unitConverters = categories.map((category) => UnitConverter(category, key: UniqueKey())).toList();

	@override
	Widget build(BuildContext context) {
		return BackdropScaffold(
			headerHeight: 56,
			frontLayerBorderRadius: BorderRadius.circular(0),
			backLayerBackgroundColor: Colors.white,
			appBar: BackdropAppBar(
				title: Text(frontIsExpanded ? "Unit Converter" : "Select category"),
				elevation: 4,
				backgroundColor: categories[selectedCategoryPosition].color,
			),
			frontLayer: unitConverters[selectedCategoryPosition],
			backLayer: BackdropNavigationBackLayer(
				items: categories.map((category) => Category(category,)).toList(),
				onTap: (position) => setState(() => selectedCategoryPosition = position),
			),
			onExpand: () => setState(() => frontIsExpanded = true),
			onCollapse: () => setState(() => frontIsExpanded = false),
		);
	}

}