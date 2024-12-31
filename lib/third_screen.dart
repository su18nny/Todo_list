import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final Function(int id) onDelete;
  final Function(int id, String title, String description) onEdit;

  const ThirdScreen({super.key, required this.id, required this.title, required this.description, required this.onDelete, required this.onEdit,});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title:  Text(
          'Task Details',
          style: TextStyle(color: Colors.tealAccent),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.black,
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Title:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                     SizedBox(height: 8),
                    isEditing
                        ? TextField(
                      controller: titleController,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Edit Title',
                        labelStyle: TextStyle(color: Colors.tealAccent),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                    )
                        : Text(
                      titleController.text,
                      style:  TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                     Divider(height: 24),
                     Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                     SizedBox(height: 8),
                    isEditing
                        ? TextField(
                      controller: descriptionController,
                      style:  TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        labelText: 'Edit Description',
                        labelStyle: TextStyle(color: Colors.tealAccent),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                      maxLines: 3,
                    )
                        : Text(
                      descriptionController.text,
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    isEditing ? Icons.save : Icons.edit,
                    color: Colors.grey[900],
                  ),
                  label: Text(
                    isEditing ? 'Save' : 'Edit',
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                  onPressed: () {
                    if (isEditing) {
                      widget.onEdit(
                        widget.id,
                        titleController.text,
                        descriptionController.text,
                      );
                    }
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    widget.onDelete(widget.id);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
