  import 'package:flutter/material.dart';
  import 'package:todo_list/second_screen.dart';
  import 'package:todo_list/third_screen.dart';
  import 'databasehelper_class.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    final DatabaseHelper _dbHelper = DatabaseHelper();
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    List<Map<String, dynamic>> _items = [];

    @override
    void initState() {
      super.initState();
      _loadItems();
    }

    void _loadItems() async {
      _items = await _dbHelper.getItems();
      setState(() {});
    }

    void _addItem() {
      final title = _titleController.text;
      final description = _descriptionController.text;

      if (title.isNotEmpty && description.isNotEmpty) {
        _dbHelper.insertItem(title, description).then((_) {
          _titleController.clear();
          _descriptionController.clear();
          _loadItems();
        });
      }
    }

    void _deleteItem(int id) {
      _dbHelper.deleteItem(id).then((_) => _loadItems());
    }

    void _updateItem(int id, String title, String description) {
      _dbHelper.updateItem(id, title, description).then((_) => _loadItems());
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title:  Text(
            'To-do List',
            style: TextStyle(
                color: Colors.tealAccent),
          ),
          backgroundColor: Colors
              .grey[850],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final title = _items[index]['title'];
                  final description = _items[index]['description'];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          title,
                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.tealAccent,
                          ),
                        ),
                        subtitle: Text(
                          description.length > 8
                              ? '${description.substring(0, 8)}...'
                              : description,
                          style: TextStyle(color: Colors.white70),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ThirdScreen(
                                    id: _items[index]['id'],
                                    title: title,
                                    description: description,
                                    onDelete: (id) => _deleteItem(id),
                                    onEdit: (id, updatedTitle,
                                        updatedDescription) =>
                                        _updateItem(
                                            id, updatedTitle, updatedDescription),
                                  ),
                            ),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon:  Icon(
                                Icons.edit,
                                color: Colors
                                    .tealAccent,
                              ),
                              onPressed: () {
                                _titleController.text = title;
                                _descriptionController.text = description;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Secondscreen(
                                          titleController: _titleController,
                                          descriptionController: _descriptionController,
                                          onSave: (title, description) {
                                            _updateItem(
                                              _items[index]['id'],
                                              title,
                                              description,
                                            );
                                          },
                                        ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon:  Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () => _deleteItem(_items[index]['id']),
                            ),
                          ],
                        ),
                      ),
                       Divider(color: Colors.yellow),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Secondscreen(
                      titleController: _titleController,
                      descriptionController: _descriptionController,
                      onSave: (title, description) {
                        _addItem();
                      },
                    ),
              ),
            );
          },
          child:  Icon(
            Icons.add,
            color: Colors.grey,
          ),
          backgroundColor: Colors.tealAccent,
        ),
      );
    }
  }
