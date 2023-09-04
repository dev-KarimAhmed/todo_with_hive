import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:mytodo_app/models/task_model.dart';

import '../constants/colors.dart';
import '../cubit/cubit/sqflite_cubit.dart';
import '../cubit/cubit/sqflite_state.dart';
import '../services/notification_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/task_tile.dart';
import 'add_task.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final DatePickerController? dateController = DatePickerController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseCubit, DatabaseState>(
      builder: (context, state) {
        List<TaskModel> tasks = DatabaseCubit.get(context).tasks ?? [];
        return Scaffold(
          body: SafeArea(
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              NotificationManager().simpleNotificationShow();
                            },
                            icon: Icon(
                              Icons.light_mode,
                              size: 25,
                            )),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${DateFormat().add_yMMMd().format(DateTime.now())}',
                              style: GoogleFonts.lato(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('Today',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                        CustomButton(
                          data: '+ Add Task',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTask()));
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    DatePicker(DateTime.now(),
                        controller: dateController,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: kPrimaryColor,
                        selectedTextColor: Colors.white,
                        dateTextStyle:
                            GoogleFonts.lato(color: Colors.grey, fontSize: 18),
                        dayTextStyle:
                            GoogleFonts.lato(color: Colors.grey, fontSize: 16),
                        monthTextStyle:
                            GoogleFonts.lato(color: Colors.grey, fontSize: 14),
                        height: 100,
                        width: 70, onDateChange: (date) {
                      // New date selected
                      DatabaseCubit.get(context).myDate =
                          DateFormat.yMMMEd().format(date).toString();
                      print(DateFormat.yMMMEd().format(date).toString());
                      print(DatabaseCubit.get(context).myDate);
                      print(DatabaseCubit.get(context).dateController.text);
                    }

                        //print(dateController);

                        ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TaskTile(
                                task: tasks[index],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
