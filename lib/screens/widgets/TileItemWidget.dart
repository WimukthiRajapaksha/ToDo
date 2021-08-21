import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/newTask.dart';
import 'package:to_do_list/providers/authService.dart';
import 'package:to_do_list/screens/addNew.dart';

class TileItemWidget extends StatefulWidget {
  final NewTask task;
  final bool showAll;
  TileItemWidget({required this.task, required this.showAll});

  @override
  _TileItemWidgetState createState() => _TileItemWidgetState();
}

class _TileItemWidgetState extends State<TileItemWidget> {
  @override
  Widget build(BuildContext context) {
    final provi = Provider.of<AuthService>(context, listen: false);
    return Padding(
      key: ValueKey(widget.task.task),
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print("Hi hi");
            Navigator.pushNamed(context, AddNew.routeName,
                arguments: widget.task);
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Checkbox(
                    value: widget.task.taskFinished,
                    onChanged: (value) {
                      setState(() {
                        widget.task.taskFinished = value!;
                      });
                      provi.toggleStatus(widget.task, widget.showAll);
                    },
                    // onChanged: null,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.task,
                        style: TextStyle(fontSize: 16),
                      ),
                      if (widget.task.date != "")
                        SizedBox(
                          height: 2,
                        ),
                      if (widget.task.date != "")
                        Row(
                          children: [
                            Text(
                              widget.task.date,
                              style: TextStyle(fontSize: 10),
                            ),
                            Icon(
                              Icons.autorenew_rounded,
                              size: 16,
                            )
                          ],
                        ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.task.list,
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue[200]),
            // height: 10,
          ),
        ),
      ),
    );
  }
}
