import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mytodo_app/models/task_model.dart';

import '../constants/colors.dart';
import '../cubit/cubit/sqflite_cubit.dart';
import '../cubit/ui_cubit.dart';
import '../cubit/ui_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/drop_down_list.dart';
import 'home_view.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController remindController = TextEditingController();
  final TextEditingController repeatTimeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UiCubit, UiState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 25,
                              )),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        data: 'Title',
                        isReadOnly: false,
                        controller: titleController,
                      ),
                      CustomTextField(
                          data: 'Add a note',
                          isReadOnly: false,
                          controller: noteController),
                      CustomTextField(
                        controller: DatabaseCubit.get(context).dateController,
                        data: 'Date',
                        suffixIcon: IconButton(
                          onPressed: () {
                            DatabaseCubit.get(context).datePicker(context);
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: startTimeController,
                              data: 'Start Time',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  timePicker(
                                    context: context,
                                    timeController: startTimeController,
                                  );
                                },
                                icon: Icon(Icons.watch_later_rounded),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomTextField(
                              controller: endTimeController,
                              data: 'End Time',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  timePicker(
                                    context: context,
                                    timeController: endTimeController,
                                  );
                                },
                                icon: Icon(Icons.watch_later_rounded),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        controller: remindController,
                        data: 'Remind',
                        suffixIcon: DropDownList(
                          onChanged: (remindValue) {
                            remindController.text = remindValue ?? '';
                          },
                          items: [
                            DropdownMenuItem(
                              value: '${5} minutes early',
                              child: Text(
                                '${5} minutes early',
                                style: GoogleFonts.lato(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: '${10} minutes early',
                              child: Text(
                                '${10} minutes early',
                                style: GoogleFonts.lato(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: '${15} minutes early',
                              child: Text(
                                '${15} minutes early',
                                style: GoogleFonts.lato(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: '${20} minutes early',
                              child: Text(
                                '${20} minutes early',
                                style: GoogleFonts.lato(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: repeatTimeController,
                        data: 'Repeat',
                        suffixIcon: DropDownList(
                          onChanged: (repeatValue) {
                            repeatTimeController.text = repeatValue ?? '';
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'none',
                              child: Text(
                                'none',
                                style: GoogleFonts.lato(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'daily',
                              child: Text(
                                'daily',
                                style: GoogleFonts.lato(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'weekly',
                              child: Text(
                                'weekly',
                                style: GoogleFonts.lato(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'monthly',
                              child: Text(
                                'monthly',
                                style: GoogleFonts.lato(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Note Color',
                                style: GoogleFonts.lato(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                children: List.generate(
                                    3,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            UiCubit.get(context)
                                                .changeColor(index);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: CircleAvatar(
                                              child: UiCubit.get(context)
                                                          .currentIndex ==
                                                      index
                                                  ? Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                      size: 14,
                                                    )
                                                  : null,
                                              backgroundColor: index == 0
                                                  ? kPrimaryColor
                                                  : index == 1
                                                      ? kAnotherColor
                                                      : kOrangeColor,
                                              radius: 16,
                                            ),
                                          ),
                                        )),
                              ),
                            ],
                          ),
                          CustomButton(
                            data: 'Create Task',
                            onTap: () async {
                              // SqfliteCubit.get(context).createDB();
                              // SqfliteCubit.get(context).insertToDB(
                              //   title: titleController.text,
                              //   note: noteController.text,
                              //   date: dateController.text,
                              //   startTime: startTimeController.text,
                              //   endTime: endTimeController.text,
                              //   remind: remindController.text,
                              //   repeat: repeatTimeController.text,
                              //   color: UiCubit.get(context).currentIndex,
                              //   isCompleted: 1,
                              // );

                              if (formKey.currentState!.validate()) {
                                TaskModel task = TaskModel(
                                  title: titleController.text,
                                  note: noteController.text,
                                  date: DatabaseCubit.get(context)
                                      .dateController
                                      .text,
                                  startTime: startTimeController.text,
                                  endTime: endTimeController.text,
                                  remind: remindController.text,
                                  repeat: repeatTimeController.text,
                                  color: UiCubit.get(context).currentIndex,
                                );
                                DatabaseCubit.get(context).createTask(task);
                                DatabaseCubit.get(context).fetchAllTasks();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String?> timePicker(
      {required BuildContext context,
      required TextEditingController timeController}) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (time == null) {
        return '';
      } else {
        timeController.text = time.format(context).toString();
        print(time.format(context));
        print(timeController.text);
      }
    });
  }
}

class ColorCircle extends StatelessWidget {
  const ColorCircle({
    super.key,
    required this.backgroundColor,
  });
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        backgroundColor: backgroundColor,
      ),
    );
  }
}
