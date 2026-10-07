import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  
  final String label;
  final List<dynamic> options;
  final String hint;
  final void Function(String?)? onChanged;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.options,
    required this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        hint: Text(hint),
        items: options.map(( value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your $label';
          }
          return null;
        },
      ),
    );
  }
}
