import 'package:flutter/material.dart';
import 'package:task_03_category_route/CategoryModel.dart';
import 'Extensions.dart';

class UnitConverter extends StatefulWidget {
	
	final CategoryModel category;

	UnitConverter(this.category, {Key key}) :
		assert(category != null),
		super(key: key);

  @override
  createState() => _UnitConverterState();

}

class _UnitConverterState extends State<UnitConverter> {

	var firstDropdownValue;
	var secondDropdownValue;

	var firstTextController = TextEditingController();
	var firstTextControllerLocked = false;
	var secondTextController = TextEditingController();
	var secondTextControllerLocked = false;

	var reverseSectionsOrder = false;

	@override
	initState() {
		super.initState();
		firstDropdownValue = widget.category.units.keys.first;
		secondDropdownValue = widget.category.units.keys.first;
		firstTextController.addListener(convertFromFirstFieldToSecond);
		secondTextController.addListener(convertFromSecondFieldToFirst);
	}

	convertFromFirstFieldToSecond() {
			if (firstTextControllerLocked) {
				return;
			}
			secondTextControllerLocked = true;
			final value = firstTextController.text;
			secondTextController.text = convert(firstDropdownValue, secondDropdownValue, value);
			secondTextControllerLocked = false;
	}

	convertFromSecondFieldToFirst() {
		if (secondTextControllerLocked) {
			return;
		}
		firstTextControllerLocked = true;
		final value = secondTextController.text;
		firstTextController.text = convert(secondDropdownValue, firstDropdownValue, value);
		firstTextControllerLocked = false;
	}

	String convert(String from, String to, String value) {
		if (value.isEmpty) {
			return "0";
		}
		final fromDivider = widget.category.units[from];
		final toDivider = widget.category.units[to];

		final multiplier = toDivider / fromDivider;
		return (double.parse(value) * multiplier).toStringAsFixed(2);
	}

	@override
	void dispose() {
		firstTextController.dispose();
		secondTextController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		final appBar = AppBar(
			title: Text(widget.category.name, style: TextStyle(color: widget.category.color),),
			backgroundColor: Colors.white,
			elevation: 0,
		);
		return Scaffold(
			appBar: appBar,
			body: buildBody(context),
		);
	}

	Widget buildBody(context) {
		final firstSection = UnitConverterSection(
			dropDownEntries: widget.category.units.keys.toList(),
			dropdownValue: firstDropdownValue,
			onDropdownValueChange: (newValue) => setState(() => firstDropdownValue = newValue),
			textController: firstTextController,
			color: widget.category.color,
		);
		final secondSection = UnitConverterSection(
			dropDownEntries: widget.category.units.keys.toList(),
			dropdownValue: secondDropdownValue,
			onDropdownValueChange: (newValue) => setState(() => secondDropdownValue = newValue),
			textController: secondTextController,
			color: widget.category.color,
		);
		final reverseButton = IconButton(
			icon: Icon(Icons.import_export),
			iconSize: 36,
			onPressed: () => setState(() => reverseSectionsOrder = !reverseSectionsOrder)
		);
		return assembleBody(firstSection, secondSection, reverseButton);
	}

	Widget assembleBody(firstSection, secondSection, reverseButton) {
		final column = Column(
			children: <Widget>[
				!reverseSectionsOrder ? firstSection : secondSection,
				reverseButton,
				!reverseSectionsOrder ? secondSection : firstSection,
			],
		);
		final orientedColumn = MediaQuery.of(context).orientation.isPortrait ?
		column :
		Center(
			child: Container(
				child: column,
				width: 450,
			),
		);

		return Container(
			color: Colors.white,
			child: SingleChildScrollView(
				child: orientedColumn,
			),
		);
	}

}

class UnitConverterSection extends StatelessWidget {

	final List<String> dropDownEntries;
	final String dropdownValue;
	final Function(String) onDropdownValueChange;
	final TextEditingController textController;
	final Color color;

  const UnitConverterSection({Key key, this.dropDownEntries, this.dropdownValue, this.onDropdownValueChange, this.textController, this.color}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.all(16.0),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					buildTextField(),
					Container(margin: EdgeInsets.only(top: 12), child: buildDropdown(dropDownEntries, dropdownValue)),
				],
			),
		);
	}

	TextField buildTextField() {
		final border = OutlineInputBorder(
				borderSide: BorderSide(color: color, width: 2.0),
				borderRadius: BorderRadius.circular(2)
		);

		return TextField(
			controller: textController,
			decoration: InputDecoration(
				focusedBorder: border,
				enabledBorder: border,
				labelText: 'Value',
			),
			style: TextStyle(fontSize: 16.0, height: 1.5),
			keyboardType: TextInputType.number,
		);
	}

	Widget buildDropdown(List<String> displayList, String value) {
		final dropdownElements = displayList.map((e) => DropdownMenuItem<String>(child: Text(e), value: e,)).toList();
		final border = BoxDecoration(border: Border.all(color: color, width: 2), borderRadius: BorderRadius.circular(2));

		return Container(
			width: double.infinity,
			decoration: border,
			child: Padding(
				padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
				child: DropdownButtonHideUnderline(
					child: DropdownButton(
						items: dropdownElements,
						onChanged: onDropdownValueChange,
						value: value,
					),
				),
			),
		);
	}

}