import 'package:flutter/material.dart';
import 'package:task_03_category_route/CategoryModel.dart';

class UnitConverterRoute extends StatefulWidget {
	
	final CategoryModel category;

	const UnitConverterRoute({@required this.category}) :
		assert(category != null);

  @override
  createState() => _UnitConverterState();

}

class _UnitConverterState extends State<UnitConverterRoute> {

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
		setupTextControllers();
	}

	void setupTextControllers() {
	  firstTextController.addListener(() {
	  	if (firstTextControllerLocked) {
	  		return;
	  	}
	  	secondTextControllerLocked = true;
	  	final value = firstTextController.text;
	  	secondTextController.text = convert(firstDropdownValue, secondDropdownValue, value);
	  	secondTextControllerLocked = false;
	  });
	  secondTextController.addListener(() {
	  	if (secondTextControllerLocked) {
	  		return;
	  	}
	  	firstTextControllerLocked = true;
	  	final value = secondTextController.text;
	  	firstTextController.text = convert(secondDropdownValue, firstDropdownValue, value);
	  	firstTextControllerLocked = false;
	  });
	}

	@override
	void dispose() {
		firstTextController.dispose();
		secondTextController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text(widget.category.name), backgroundColor: widget.category.color,),
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

		return Column(
			children: <Widget>[
				!reverseSectionsOrder ? firstSection : secondSection,
				reverseButton,
				!reverseSectionsOrder ? secondSection : firstSection,
			],
		);
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

	Widget buildDropdown(List<String> displayList, String value) {
		final dropdownElements = displayList.map((e) => DropdownMenuItem<String>(child: Text(e), value: e,)).toList();
		final border = BoxDecoration(border: Border.all(color: color, width: 2), borderRadius: BorderRadius.circular(2));

		return Center(
			child: Container(
				width: double.infinity,
				decoration: border,
				child: Padding(
					padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
					child: DropdownButtonHideUnderline(
						child: DropdownButton(
							items: dropdownElements,
							onChanged: onDropdownValueChange,
							underline: null,
							value: value,
						),
					),
				),
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

}