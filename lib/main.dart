import 'package:bons_it/view/home_view/bloc/home_bloc.dart';
import 'package:bons_it/view/home_view/home_view.dart';
import 'package:bons_it/view/runner_view/bloc/runner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bons It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        cardTheme: const CardTheme(
          margin: EdgeInsets.zero,
        ),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeBloc(),
          ),
          BlocProvider(
            create: (_) => RunnerBloc(),
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
