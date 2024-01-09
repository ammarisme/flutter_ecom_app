import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_properties.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const ActionButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            gradient: MAIN_BUTTON_GRADIENTS,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text(this.buttonText,
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );
  }
}

class SearchableDropDown extends StatelessWidget {
  List<dynamic> selectableItems;
  String label;
  String hint;

  SearchableDropDown(
      {required this.selectableItems, required this.label, required this.hint});

  @override
  Widget build(Object context) {
    return DropdownSearch<dynamic>(
        items: selectableItems,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: label,
            hintText: hint,
          ),
        ));
  }
}


class CustomTextField extends StatefulWidget {
final String placeholder_text;
  final void Function(String)? onChange;
  final Icon icon;
  final String defaultValue;
  TextFieldType fieldType = TextFieldType.text; 

  TextEditingController textEditingController = TextEditingController();

  CustomTextField(
      {Key? key,
      required this.placeholder_text,
      required this.onChange,
      required this.icon,
      required this.defaultValue,
      required this.fieldType
      })
      : super(key: key);
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}


class _CustomTextFieldState extends State<CustomTextField> {

@override
void initState() {
  super.initState();
  // Make API call here
      widget.textEditingController.text = widget.defaultValue;
}



  Widget build(BuildContext context) {
    widget.textEditingController.text = widget.defaultValue;
    widget.textEditingController..selection = TextSelection.fromPosition(TextPosition(offset:  widget.textEditingController.text.length));
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: TextField(
        obscureText: widget.fieldType ==  TextFieldType.password,
        controller: widget.textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.placeholder_text,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14
            ),
            prefixIcon: widget.icon),
        onChanged: widget.onChange, // Icon before the input
      ),
    );
  }
}

enum TextFieldType{
  password,
  text
}

class CustomDropDownField extends StatefulWidget {
  final List<String> input_list;
  final String placeholder_text;
  final void Function(String?) onChange;
  final Icon icon;
  final String defaultValue;

  const CustomDropDownField(
      {Key? key,
      required this.input_list,
      required this.placeholder_text,
      required this.onChange,
      required this.icon,
      required this.defaultValue})
      : super(key: key);

  @override
  _CustomDropDownFieldState createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  DropdownButtonFormField<String>? dropdownBtn;
  @override
  void initState() {
    super.initState();
    // Make API call here
  }

  Widget build(BuildContext context) {
    dropdownBtn =  DropdownButtonFormField<String>(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.placeholder_text,
            prefixIcon: widget.icon),
        items: widget.input_list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: widget.onChange,
        value:  widget.input_list.length > 0 ? widget.input_list[0] : "", // Track the selected area
      );


    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: dropdownBtn );
  }
}
