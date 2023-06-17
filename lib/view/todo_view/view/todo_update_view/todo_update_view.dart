import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/model/task_item.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/util/dialog.dart';
import 'package:bons_it/view/label_view/view/label_select_view/label_select_view.dart';
import 'package:bons_it/view/todo_view/view/todo_update_view/bloc/todo_update_bloc.dart';
import 'package:bons_it/widget/label_list_tile.dart';
import 'package:bons_it/widget/loading.dart';

class TodoUpdateView extends StatefulWidget {
  const TodoUpdateView({
    super.key,
    required this.item,
  });
  final TaskItem? item;

  static MaterialPageRoute route({
    TaskItem? item,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => TodoUpdateBloc(
            RepositoryProvider.of<TaskRepo>(context),
          ),
          child: TodoUpdateView(
            item: item,
          ),
        );
      },
    );
  }

  @override
  State<TodoUpdateView> createState() => _TodoUpdateViewState();
}

class _TodoUpdateViewState extends State<TodoUpdateView> {
  TodoUpdateBloc get bloc => BlocProvider.of<TodoUpdateBloc>(context);

  @override
  void initState() {
    super.initState();
    bloc.add(TodoUpdateStarted(widget.item));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Update Todo"),
      leading: IconButton(
        onPressed: () {
          bloc.add(TodoUpdateLeftView());
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget titleTextField({
    required TaskItem taskItem,
    required TextEditingController titleController,
  }) {
    return TextField(
      controller: titleController,
      decoration: const InputDecoration(
        hintText: "Enter Title..",
      ),
      onChanged: (value) {
        bloc.add(
          TodoUpdateChangedTask(
            taskItem.copyWith(title: value),
          ),
        );
      },
    );
  }

  Widget labelPicker({
    required TaskItem taskItem,
    required List<Label> labelList,
    required List<String> selectedLabelList,
  }) {
    void selectLabel() async {
      final List<String>? res = await Navigator.of(context).push(
        LabelSelectView.route(
          selectedLabelList: selectedLabelList,
        ),
      );
      if (res != null) {
        bloc.add(
          TodoUpdateChangedTask(
            taskItem.copyWith(labelIndexList: res),
          ),
        );
      }
    }

    if (selectedLabelList.isEmpty) {
      return ElevatedButton(
        onPressed: selectLabel,
        child: const Text("New Label"),
      );
    }
    return Column(
      children: selectedLabelList.map(
        (labelIndex) {
          final index = labelList.indexWhere((e) => e.index == labelIndex);
          if (index == -1) {
            return const SizedBox();
          }
          return LabelListTile(
            label: labelList[index],
            onTap: () {
              selectLabel();
            },
          );
        },
      ).toList(),
    );
  }

  Widget updateButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          bloc.add(TodoUpdateCompleted());
        },
        child: const Text("Update"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocListener<TodoUpdateBloc, TodoUpdateState>(
        listener: (context, state) async {
          final status = state.status;
          if (status == TodoUpdateViewStatus.completed) {
            Navigator.of(context).pop();
          }
          if (status == TodoUpdateViewStatus.leave) {
            final isChanged = state.isChanged;
            if (!isChanged) {
              Navigator.of(context).pop();
              return;
            }
            TodoDialog.show(
              context: context,
              message: "LEAVE WITHOUT SAVE?",
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Leave"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Stay.."),
                )
              ],
            ).then((res) {
              if (res != null && res) {
                Navigator.of(context).pop();
              }
            });
          }
        },
        child: BlocBuilder<TodoUpdateBloc, TodoUpdateState>(
          builder: (context, state) {
            final status = state.status;
            switch (status) {
              case TodoUpdateViewStatus.init:
              case TodoUpdateViewStatus.loading:
                return const TodoLoading();
              case TodoUpdateViewStatus.success:
              case TodoUpdateViewStatus.faiure:
              case TodoUpdateViewStatus.completed:
              case TodoUpdateViewStatus.leave:
            }
            final taskItem = state.taskItem;
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              children: [
                titleTextField(
                  taskItem: taskItem,
                  titleController: state.titleController,
                ),
                const SizedBox(height: 16.0),
                labelPicker(
                  taskItem: taskItem,
                  labelList: state.labelList,
                  selectedLabelList: taskItem.labelIndexList,
                ),
                const SizedBox(height: 16.0),
                updateButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
