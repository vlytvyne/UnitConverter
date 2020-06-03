import 'package:flutter/material.dart';

class CategoryModel {

	final String name;
	final String iconLocation;
	final Color color;
	final Map<String, double> units;

	CategoryModel(this.name, this.iconLocation, this.color, this.units);
}

final categories = [
	CategoryModel('Length', 'assets/icons/ruler.png', Colors.red, { 'km': 1, 'meter': 1000, 'cm': 100000,}),
	CategoryModel('Weight', 'assets/icons/weight.png', Colors.pink, {'kilogram': 1, 'gram': 1000, 'milligram': 100000}),
	CategoryModel('Time', 'assets/icons/clock.png', Colors.blue, {'hour': 1, 'minute': 60, 'second': 3600})
];