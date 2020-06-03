import 'package:flutter/material.dart';

extension OrientationExtension on Orientation {

	get isPortrait => this == Orientation.portrait;
}