import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodo_app/constants/colors.dart';
import 'package:mytodo_app/cubit/ui_cubit.dart';

import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: UiCubit.get(context).taskColor(task.color),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${task.startTime} - ${task.endTime}',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.grey[100],
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    task.note,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            decoration: BoxDecoration(
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              "Completed",
              // task.isCompleted == 0 ? 'TODO' : 'Completed',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
