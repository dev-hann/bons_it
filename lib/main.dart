import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/view/home_view/bloc/home_bloc.dart';
import 'package:bons_it/view/home_view/home_view.dart';
import 'package:bons_it/view/todo_view/bloc/todo_bloc.dart';
import 'package:bons_it/view/label_view/bloc/label_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider<TaskRepo>(
          create: (_) => TaskImpl(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final taskRepo = RepositoryProvider.of<TaskRepo>(context);
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeBloc(),
          ),
          BlocProvider(
            create: (_) => TodoBloc(
              taskRepo,
            ),
          ),
          BlocProvider(
            create: (_) => LabelBloc(
              taskRepo,
            ),
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
