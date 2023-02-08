import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
/*------------------------------------------------
            saves list to shared prefrences
--------------------------------------------------*/
  void setlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawJson = jsonEncode(numberdata);
    prefs.setString('my_string_key', rawJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            textbox(controller: namecontroller, label: "Item Name"),
            textbox(
                controller: pricecontroller,
                label: "Item Price",
                textInputType: TextInputType.number),
            textbox(
                controller: quantitycontroller,
                label: "Item Quantity",
                textInputType: TextInputType.number),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    numberdata.add({
                      "name": namecontroller.text,
                      "price": pricecontroller.text,
                      "quantity": quantitycontroller.text
                    });
                    setState(() {
                      setlist();
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Item'))
          ],
        ),
      ),
    );
  }
}
