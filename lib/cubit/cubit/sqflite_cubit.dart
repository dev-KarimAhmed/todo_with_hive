import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mytodo_app/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:mytodo_app/cubit/cubit/sqflite_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DBInitial());
  static DatabaseCubit get(context) => BlocProvider.of(context);

  // Database? database;

  // void createDB() {
  //   openDatabase(
  //     'todo.db',
  //     version: 1,
  //     onCreate: (Database database, int version) async {
  //       print('database created');

  //       await database.execute(
  //           'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, '
  //           'title STRING ,note TEXT, date STRING '
  //           'startTime STRING ,endTime STRING, '
  //           'remind INTEGER , repeat STRING, '
  //           'color INTEGER, '
  //           'isCompleted INTEGER)');
  //     },
  //     onOpen: (database) {
  //       print('database Opened');
  //       getDataFromDB(database);
  //     },
  //   ).then((value) {
  //     database = value;
  //     print('$value is your databse');
  //     emit(CreateDB());
  //   });
  // }

  // void insertToDB({
  //   required String title,
  //   required String note,
  //   required String date,
  //   required String startTime,
  //   required String endTime,
  //   required String remind,
  //   required String repeat,
  //   required int color,
  //   required int isCompleted,
  // }) async {
  //   if (database == null) {
  //     print('null');
  //   } else {
  //     await database!.transaction((txn) async {
  //       txn
  //           .rawInsert(
  //               'INSERT INTO tasks(title,note,date,endTime,remind,repeat,color,isCompleted,startTime) VALUES("$title","$note","$date","$endTime","$remind","$repeat","$color","$isCompleted","$startTime")')
  //           .then((value) {
  //         print('Data Inserted successfuly');
  //         emit(InsertDB());
  //         //  getDataFromDB(database);
  //       }).catchError((error) {
  //         print('error while inserting...${error.toString()}');
  //       });
  //     });
  //   }
  // }

  // void getDataFromDB(Database database) async {
  //   //newTasks = [];
  //   //doneTasks = [];
  //   //archivedTasks = [];
  //   database.rawQuery('SELECT * FROM tasks').then((value) {
  //     value.forEach((element) {
  //       // if (element['status'] == 'new') {
  //       //   newTasks.add(element);
  //       // } else if (element['status'] == 'done') {
  //       //   doneTasks.add(element);
  //       // } else {
  //       //   archivedTasks.add(element);
  //       // }
  //       print(element);
  //       print(value);
  //     });
  //     emit(GetDB());
  //   });
  // }

  void createTask(TaskModel task) async {
    try {
      var taskBox = Hive.box<TaskModel>('task_box');
      await taskBox.add(task);
      emit(CreateDB());
    } on Exception catch (e) {
      print(e);
    }
  }

  TaskModel? task;
  List<TaskModel>? tasks;
  fetchAllTasks() async {
    try {
      var taskBox = Hive.box<TaskModel>('task_box');
      tasks = taskBox.values.toList();
      emit(FetchTasks(task: tasks!));
    } on Exception catch (e) {
      print(e);
    }
  }

  final TextEditingController dateController = TextEditingController();

  Future<String?> datePicker(BuildContext context) {
    return showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: DateTime.now(),
            lastDate: DateTime.parse('2030-12-31'))
        .then((date) {
      if (date == null) {
        return '';
      } else {
        dateController.text = DateFormat.yMMMEd().format(date).toString();
        print(date);
        print(dateController.text);
      }
    });
  }

  String? myDate;
}
