import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bons_it/model/task_item.dart';
import 'package:bons_it/util/dialog.dart';
import 'package:bons_it/view/todo_view/bloc/todo_bloc.dart';
import 'package:bons_it/view/todo_view/view/todo_update_view/todo_update_view.dart';
import 'package:bons_it/widget/task_item_list_tile.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TodoBloc get bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    bloc.add(TodoEventStarted());
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
      TodoEventRemovedTaskItem(index),
    );
  }

  FloatingActionButton updateButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          TodoUpdateView.route(),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: updateButton(),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          final list = state.itemList;
          if (list.isEmpty) {
            return const Text("empty");
          }
          return SlidableAutoCloseBehavior(
            child: ReorderableList(
              onReorder: (int oldIndex, int newIndex) {},
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return Card(
                  key: ValueKey(index),
                  clipBehavior: Clip.hardEdge,
                  child: TaskItemListTile(
                    index: index,
                    taskItem: item,
                    onTap: () {
                      Navigator.of(context).push(
                        TodoUpdateView.route(
                          item: item,
                        ),
                      );
                    },
                    onTapDelete: () async {
                      onTapDelete(item.index);
                    },
                    onTapCheck: () {
                      bloc.add(
                        TodoEventUpdatedTaskItem(
                          item.copyWith(
                            status: item.status == TaskItemStatus.completed
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
