import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  final int id = 1;
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String note;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String startTime;
  @HiveField(4)
  final String endTime;
  @HiveField(5)
  final String remind;
  @HiveField(6)
  final String repeat;
  @HiveField(7)
  final int color;

  TaskModel({
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.repeat,
    required this.color,
  });
}
