import 'package:flutter/material.dart';

class ListToAddFormWidget extends StatefulWidget {
  final String? listToAdd;
  // final Function listToAddFormHandler;

  ListToAddFormWidget({required this.listToAdd
      // , required this.listToAddFormHandler
      });

  @override
  _ListToAddFormWidgetState createState() => _ListToAddFormWidgetState();
}

class _ListToAddFormWidgetState extends State<ListToAddFormWidget> {
  final _newListNameController = TextEditingController();

  final List<String> listTypes = [
    "Default",
    "Personal",
    "Shopping",
    "Wishlist",
    "Work"
  ];

  String? _currentList;

  @override
  void initState() {
    super.initState();
    this._currentList =
        (widget.listToAdd != null) ? widget.listToAdd : this.listTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add to List",
          style:
              TextStyle(color: Colors.blue[200], fontWeight: FontWeight.w900),
        ),
        Row(
          children: [
            Expanded(
              // width: 200,
              child: DropdownButton<String>(
                  underline: Container(),
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  value: this._currentList,
                  // style: TextStyle(color: Colors.blue[200]),
                  onChanged: (String? value) {
                    // print(value);
                    setState(() {
                      this._currentList = value!;
                    });
                    // widget.listToAddFormHandler(this._currentList);
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return this.listTypes.map((String value) {
                      return Center(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList();
                  },
                  items: this
                      .listTypes
                      .map((item) => DropdownMenuItem(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            value: item,
                          ))
                      .toList()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: InkWell(
                child: Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: Text(
                            "New List",
                            style: TextStyle(color: Colors.blue),
                          ),
                          content: TextField(
                            controller: this._newListNameController,
                            decoration:
                                InputDecoration(hintText: "Enter List Name"),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                this._newListNameController.text = "";
                                Navigator.of(context).pop();
                              },
                              child: Text("CANCEL"),
                            ),
                            TextButton(
                              onPressed: () {
                                this
                                    .listTypes
                                    .add(this._newListNameController.text);
                                setState(() {
                                  this._currentList =
                                      this._newListNameController.text;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("ADD"),
                            )
                          ],
                        );
                      });
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
