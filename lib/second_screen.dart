import 'package:flutter/material.dart';

class Secondscreen extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Function(String, String) onSave;

  const Secondscreen({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title:  Text(
          'Add or Edit Task',
          style: TextStyle(color: Colors.tealAccent),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration:  InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.tealAccent),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
              ),
              style:  TextStyle(color: Colors.white),
            ),
             SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.tealAccent),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
              ),
              style:  TextStyle(color: Colors.white),
            ),
             SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                if (title.isNotEmpty && description.isNotEmpty) {
                  onSave(title, description);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.grey)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent
              ),
            ),
          ],
        ),
      ),
    );
  }
}
