import 'package:bons_it/view/dash_board_view/bloc/dash_board_bloc.dart';
import 'package:bons_it/view/dash_board_view/view/todo_folder_grid_view/todo_folder_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  DashBoardBloc get bloc => BlocProvider.of<DashBoardBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardBloc, DashBoardState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TodoFolderGridView(
              folderList: state.todoFolderList,
              onTapAdd: () {},
            ),
          ],
        );
      },
    );
  }
}
