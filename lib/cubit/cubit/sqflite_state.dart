// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../models/task_model.dart';

abstract class DatabaseState {}

class DBInitial extends DatabaseState {}

class CreateDB extends DatabaseState {}

class FetchTasks extends DatabaseState {
  List<TaskModel> task;
  FetchTasks({
    required this.task,
  });
}

class InsertDB extends DatabaseState {}

class GetDB extends DatabaseState {}
