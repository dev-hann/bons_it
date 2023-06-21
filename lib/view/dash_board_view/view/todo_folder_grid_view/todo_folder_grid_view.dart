import 'package:bons_it/model/todo_folder.dart';
import 'package:flutter/material.dart';

class TodoFolderGridView extends StatelessWidget {
  const TodoFolderGridView({
    super.key,
    required this.folderList,
    required this.onTapAdd,
  });
  final List<TodoFolder> folderList;
  final VoidCallback onTapAdd;

  Widget filterPicker() {
    return Row(
      children: [
        const Icon(Icons.arrow_drop_down),
        const Text("Recent"),
        const Spacer(),
        GestureDetector(
          onTap: onTapAdd,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget gridView({
    required List<TodoFolder> list,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final folder = list[index];
        return TodoFolderCard(
          folder: folder,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        filterPicker(),
        gridView(
          list: folderList,
        )
      ],
    );
  }
}

class TodoFolderCard extends StatelessWidget {
  const TodoFolderCard({
    super.key,
    required this.folder,
  });
  final TodoFolder folder;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(folder.title),
    );
  }
}
