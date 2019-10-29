import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:scopedmodeltest/models/employeeModel.dart';
import 'package:scopedmodeltest/utilities/utils.dart';
import 'package:sqflite/sqflite.dart';

class InternalDatabase {
  final String _dbName = "EmployeeInformation";

  Database _database;

  Future<Database> _getDataBase() async {
    if (_database == null) {
      _database = await _initDeleteDb(_dbName);
    }

    return _database;
  }

  Future<Database> _initDeleteDb(String dbName) async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, dbName);
    final database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE employees(id INTEGER PRIMARY KEY, employeeName TEXT, employeeSalary REAL, employeeAge INTEGER, profileImage TEXT, rating REAL)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertEmployee(List<EmployeeModel> employeeModels) async {
    // Get a reference to the database.
    final Database db = await _getDataBase();

    for (final item in employeeModels) {
      final String query =
          "INSERT OR IGNORE INTO employees (id,employeeName,employeeSalary,employeeAge,profileImage,rating) VALUES (${item.id},'${item.employeeName}',${item.employeeSalary},${item.employeeAge},'${item.profileImage}',0)";

      await db.rawQuery(query);

      logger.d("query = $query");
    }
  }

  Future<List<EmployeeModel>> allEmployee() async {
    final query = "SELECT * FROM employees";

    final Database database = await _getDataBase();

    final dbData = await database.rawQuery(query);

    final List<EmployeeModel> data = List<EmployeeModel>();

    dbData.forEach((value) {
      final employeeModel = EmployeeModel(
          employeeName: value['employeeName'],
          employeeSalary: value['employeeSalary'].toString(),
          employeeAge: value['employeeAge'].toString(),
          profileImage: value['profileImage'].toString(),
          rating: value['rating'],
          id: value['id'].toString());
      data.add(employeeModel);
    });

    logger.d("SqlQuery: $query");
    logger.d("dataFound: $dbData");

    return data;
  }
}

final internalDatabase = InternalDatabase();

/*
String id;
String employeeName;
String employeeSalary;
String employeeAge;
String profileImage;*/
