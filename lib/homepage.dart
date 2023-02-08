import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/additem.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detailitem.dart';

List numberdata = [
  {
    'name': 'Item 1',
    'price': '100',
    'quantity': '10',
  },
  {
    'name': 'Item 2',
    'price': '200',
    'quantity': '20',
  },
  {
    'name': 'Item 3',
    'price': '300',
    'quantity': '30',
  },
  {
    'name': 'Item 4',
    'price': '400',
    'quantity': '40',
  },
  {
    'name': 'Item 5',
    'price': '500',
    'quantity': '50',
  },
  {
    'name': 'Item 6',
    'price': '600',
    'quantity': '60',
  },
  {
    'name': 'Item 7',
    'price': '700',
    'quantity': '70',
  },
  {
    'name': 'Item 8',
    'price': '800',
    'quantity': '80',
  },
  {
    'name': 'Item 9',
    'price': '900',
    'quantity': '90',
  },
  {
    'name': 'Item 10',
    'price': '1000',
    'quantity': '100',
  },
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController searchcontroller = TextEditingController();
final _searchResult = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    recoverlist();
  }

/*------------------------------------------------
            saves list to shared prefrences
--------------------------------------------------*/
  void setlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawJson = jsonEncode(numberdata);
    prefs.setString('my_string_key', rawJson);
  }

/*------------------------------------------------
            retrives list to shared prefrences
--------------------------------------------------*/
  void recoverlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString('my_string_key') ?? '';
    setState(() {
      numberdata = jsonDecode(rawJson);
    });
  }

/*------------------------------------------------
              delete list to shared prefrences
--------------------------------------------------*/
  void removelist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('my_string_key');
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (int i = 0; i < numberdata.length; i++) {
      if (numberdata[i]['name'].contains(text)) {
        _searchResult.add(numberdata[i]);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                      labelText: "Search",
                      labelStyle: TextStyle(color: Colors.grey[800]),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 2.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 2.0),
                      ),
                    ),
                    onChanged: (value) {
                      onSearchTextChanged(value);
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Search cannot be empty";
                      } else {
                        return null;
                      }
                    })),
            searchcontroller.text.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.78,
                    child: ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (() async {}),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Item Name: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          _searchResult[index]['name'],
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Item Price: Rs.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              _searchResult[index]['price'],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Item Qunatity: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              _searchResult[index]['quantity'],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListTile(
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            numberdata.removeAt(index);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.78,
                    child: ListView.builder(
                      itemCount: numberdata.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (() async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailItem(
                                          index: index,
                                        )));

                            setState(() {});
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Item Name: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          numberdata[index]['name'],
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Item Price: Rs.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              numberdata[index]['price'],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Item Qunatity: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              numberdata[index]['quantity'],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListTile(
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            numberdata.removeAt(index);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItem()),
          );
          setState(() {
            setlist();
          });
        },
        child: const Icon(Icons.add),

      ),
    );
  }
}
