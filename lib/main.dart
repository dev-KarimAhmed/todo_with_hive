import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytodo_app/models/task_model.dart';
import 'package:mytodo_app/services/notification_service.dart';
import 'package:mytodo_app/views/home_view.dart';
import 'cubit/cubit/sqflite_cubit.dart';
import 'cubit/observer.dart';
import 'cubit/ui_cubit.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
 // await NotificationManager().initNotification();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('task_box');
  
  Bloc.observer = SimpleBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<UiCubit>(
        create: (context) => UiCubit(),
      ),
      BlocProvider<DatabaseCubit>(
        create: (context) => DatabaseCubit(),
      ),
    ],
    child: const TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SqfliteCubit.get(context).createDB();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mytodo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: HomePage(),
    );
  }
}
