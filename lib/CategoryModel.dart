import 'package:flutter/material.dart';

class CategoryModel {

	final String name;
	final IconData icon;
	final Color color;
	final Map<String, double> units;

	CategoryModel(this.name, this.icon, this.color, this.units);
}

final categories = [
	CategoryModel('Length', Icons.network_cell, Colors.red, { 'km': 1, 'meter': 1000, 'cm': 100000,}),
	CategoryModel('Weight', Icons.cloud, Colors.pink, {'kilogram': 1, 'gram': 1000, 'milligram': 100000}),
	CategoryModel('Time', Icons.watch_later, Colors.blue, {'hour': 1, 'minute': 60, 'second': 3600})
];