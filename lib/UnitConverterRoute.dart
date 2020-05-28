import 'package:flutter/material.dart';
import 'package:task_03_category_route/CategoryModel.dart';

class UnitConverterRoute extends StatelessWidget {
	
	final CategoryModel category;

	const UnitConverterRoute({
		@required this.category
	}) :
		assert(category != null);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text(category.name), backgroundColor: category.color,),
			body: buildBody(context),
		);
	}

	Widget buildBody(context) {
		return Column(
		  children: <Widget>[
		    buildSection('Input', category.units.keys.toList()),
			  Icon(Icons.import_export, size: 36,),
			  buildSection('Output', category.units.keys.toList())
		  ],
		);
	}

	Padding buildSection(String inputLabel, List<String> dropdownDisplayList) {
	  return Padding(
	    padding: EdgeInsets.all(16.0),
	    child: Column(
	  	  mainAxisSize: MainAxisSize.min,
	    	children: <Widget>[
	    		buildTextField(inputLabel),
	    		Container(margin: EdgeInsets.only(top: 12),child: buildDropdown(dropdownDisplayList)),
	    	],
	    ),
	  );
	}

	Center buildDropdown(List<String> displayList) {
	  final dropdownElements = displayList.map((e) => DropdownMenuItem<String>(child: Text(e),)).toList();

	  return Center(
	    child: Container(
	  	  width: double.infinity,
	    	decoration: BoxDecoration(border: Border.all(color: category.color, width: 2), borderRadius: BorderRadius.circular(2)),
	      child: Padding(
	        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
	        child: DropdownButtonHideUnderline(
	          child: DropdownButton(
	          	items: dropdownElements,
	          	onChanged: (_) => null,
	          	underline: null,
	          ),
	        ),
	      ),
	    ),
	  );
	}

	TextField buildTextField(String label) {
	  return TextField(
					decoration: InputDecoration(
						focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: category.color, width: 2.0), borderRadius: BorderRadius.circular(2)),
			      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: category.color, width: 2.0), borderRadius: BorderRadius.circular(2)),
						labelText: label,
					),
					style: TextStyle(fontSize: 16.0, height: 1.5),
					keyboardType: TextInputType.number,
				);
	}
}

//class Converter extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => _ConverterState();
//}
//
//class _ConverterState extends State<Converter> {
//  var text = "";
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 32.0),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          TextField(
//            onChanged: (text) {
//              setState(() {
//                this.text = text;
//              });
//            },
//          ),
//          Text(text),
//        ],
//      ),
//    );
//  }
//}
