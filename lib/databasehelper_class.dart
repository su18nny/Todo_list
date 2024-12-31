import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton pattern to ensure only one instance of DatabaseHelper is created
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  // Variable to hold the database instance
  static Database? _database;

  // Private constructor for singleton implementation
  DatabaseHelper._internal();

  // Getter to access the database instance, ensuring it is initialized before use
  Future<Database> get database async {
    // Initialize the database if it is not already initialized
    _database ??= await _initDB();
    return _database!;
  }

  // Method to initialize the SQLite database
  Future<Database> _initDB() async {
    // Get the path where the database will be stored on the device
    String path = join(await getDatabasesPath(), 'todo.db');

    // Open or create the database with version 1 and execute onCreate callback to set up the schema
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // SQL query to create a table named 'items' with columns 'id', 'title', and 'description'
        await db.execute('''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  // Method to insert a new item into the 'items' table
  Future<void> insertItem(String title, String description) async {
    final db = await database;
    try {

      await db.insert(
        'items',
        {'title': title, 'description': description},
      );
    } catch (e) {
      print("Error inserting item: $e");
    }
  }


  // Method to retrieve all items from the 'items' table
  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    // Query the 'items' table and return the list of rows
    return await db.query('items');
  }


  Future<void> updateItem(int id, String title, String description) async {
    final db = await database;
    try {

      await db.update(
        'items',
        {'title': title, 'description': description},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error updating item: $e");
    }
  }


  Future<void> deleteItem(int id) async {
    final db = await database;
    try {

      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Error deleting item: $e");
    }
  }
}
