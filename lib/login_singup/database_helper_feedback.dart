// database_helper.dart
import 'package:expense/navbar/feedback_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperFeedback {
  static Database? _database;
  static final DatabaseHelperFeedback instance = DatabaseHelperFeedback._();

  DatabaseHelperFeedback._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, 'feedback_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE feedbacks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userName TEXT,
        feedbackText TEXT
      )
    ''');
  }

  Future<int> insertFeedback(FeedbackModel feedback) async {
    final db = await database;
    return await db.insert('feedbacks', feedback.toMap());
  }

  Future<List<FeedbackModel>> getAllFeedbacks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('feedbacks');
    return List.generate(maps.length, (index) {
      return FeedbackModel.fromMap(maps[index]);
    });
  }
}
