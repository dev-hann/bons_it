import 'package:bons_it/view/dash_board_view/dash_board_view.dart';
import 'package:bons_it/view/folder_view/folder_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bons_it/view/home_view/bloc/home_bloc.dart';
import 'package:bons_it/view/label_view/label_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeBloc get bloc => BlocProvider.of<HomeBloc>(context);

  @override
  void initState() {
    super.initState();
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Bons It"),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return PageView(
            children: const [
              DashBoardView(),
              FolderView(),
              LabelView(),
            ],
          );
        },
      ),
    );
  }
}
