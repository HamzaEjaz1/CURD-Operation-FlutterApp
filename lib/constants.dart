import 'package:flutter/material.dart';

Widget textbox(
    {required TextEditingController controller,
    required String label,
    TextInputType textInputType = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[800]),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.orange, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.orange, width: 2.0),
          ),
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return "$label cannot be empty";
          } else {
            return null;
          }
        }),
  );
}
