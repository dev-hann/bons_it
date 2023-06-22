import 'package:bons_it/view/folder_view/bloc/folder_bloc.dart';
import 'package:bons_it/view/folder_view/view/folder_update_view/folder_update_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bons_it/model/todo_item.dart';
import 'package:bons_it/util/dialog.dart';
import 'package:bons_it/widget/task_item_list_tile.dart';

class FolderView extends StatefulWidget {
  const FolderView({super.key});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  FolderBloc get bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    bloc.add(FolderEventStarted());
  }

  void onTapDelete(String index) async {
    final res = await TodoDialog.show(
      context: context,
      message: "DELETE?",
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text("DELETE"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
    if (res == null) {
      return;
    }
    bloc.add(
      FolderEventRemovedTaskItem(index),
    );
  }

  FloatingActionButton updateButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          FolderUpdateView.route(),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: updateButton(),
      body: BlocBuilder<FolderBloc, FolderState>(
        builder: (context, state) {
          final list = state.itemList;
          if (list.isEmpty) {
            return const Center(
              child: Text("Empty View"),
            );
          }
          return SlidableAutoCloseBehavior(
            child: ReorderableList(
              padding: const EdgeInsets.all(16.0),
              onReorder: (int oldIndex, int newIndex) {},
              itemCount: list.length,
              itemBuilder: (context, index) {
                final folder = list[index];
                return Card(
                  key: ValueKey(index),
                  clipBehavior: Clip.hardEdge,
                  child: TaskItemListTile(
                    index: index,
                    taskItem: folder,
                    onTap: () {
                      // Navigator.of(context).push(
                      //   FolderUpdateView.route(
                      //     item: item,
                      //   ),
                      // );
                    },
                    onTapDelete: () async {
                      onTapDelete(folder.index);
                    },
                    onTapCheck: () {
                      bloc.add(
                        FolderEventUpdatedTaskItem(
                          folder.copyWith(
                            status: folder.status == TaskItemStatus.completed
                                ? TaskItemStatus.none
                                : TaskItemStatus.completed,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
