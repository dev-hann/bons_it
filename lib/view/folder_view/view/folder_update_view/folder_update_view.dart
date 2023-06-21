import 'package:bons_it/model/todo_folder.dart';
import 'package:bons_it/view/folder_view/view/folder_update_view/bloc/folder_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/util/dialog.dart';
import 'package:bons_it/widget/loading.dart';

class FolderUpdateView extends StatefulWidget {
  const FolderUpdateView({
    super.key,
    required this.item,
  });
  final TodoFolder? item;

  static MaterialPageRoute route({
    TodoFolder? item,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => FolderUpdateBloc(
            RepositoryProvider.of<TaskRepo>(context),
          ),
          child: FolderUpdateView(
            item: item,
          ),
        );
      },
    );
  }

  @override
  State<FolderUpdateView> createState() => _FolderUpdateViewState();
}

class _FolderUpdateViewState extends State<FolderUpdateView> {
  FolderUpdateBloc get bloc => BlocProvider.of<FolderUpdateBloc>(context);

  @override
  void initState() {
    super.initState();
    bloc.add(FolderUpdateStarted(widget.item));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Update Todo"),
      leading: IconButton(
        onPressed: () {
          bloc.add(FolderUpdateLeftView());
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget titleTextField({
    required TodoFolder folder,
    required TextEditingController titleController,
  }) {
    return TextField(
      controller: titleController,
      decoration: const InputDecoration(
        hintText: "Enter Title..",
      ),
      onChanged: (value) {
        bloc.add(
          FolderUpdateChangedFolder(
            folder.copyWith(title: value),
          ),
        );
      },
    );
  }

  // Widget labelPicker({
  //   required TodoFolder folder,
  //   required List<Label> labelList,
  //   required List<String> selectedLabelList,
  // }) {
  //   void selectLabel() async {
  //     final List<String>? res = await Navigator.of(context).push(
  //       LabelSelectView.route(
  //         selectedLabelList: selectedLabelList,
  //       ),
  //     );
  //     if (res != null) {
  //       bloc.add(
  //         FolderUpdateChangedFolder(
  //           taskItem.copyWith(labelIndexList: res),
  //         ),
  //       );
  //     }
  //   }

  //   if (selectedLabelList.isEmpty) {
  //     return ElevatedButton(
  //       onPressed: selectLabel,
  //       child: const Text("New Label"),
  //     );
  //   }
  //   return Column(
  //     children: selectedLabelList.map(
  //       (labelIndex) {
  //         final index = labelList.indexWhere((e) => e.index == labelIndex);
  //         if (index == -1) {
  //           return const SizedBox();
  //         }
  //         return LabelListTile(
  //           label: labelList[index],
  //           onTap: () {
  //             selectLabel();
  //           },
  //         );
  //       },
  //     ).toList(),
  //   );
  // }

  Widget updateButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          bloc.add(FolderUpdateCompleted());
        },
        child: const Text("Update"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocListener<FolderUpdateBloc, FolderUpdateState>(
        listener: (context, state) async {
          final status = state.status;
          if (status == FolderUpdateViewStatus.completed) {
            Navigator.of(context).pop();
          }
          if (status == FolderUpdateViewStatus.leave) {
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
        child: BlocBuilder<FolderUpdateBloc, FolderUpdateState>(
          builder: (context, state) {
            final status = state.status;
            switch (status) {
              case FolderUpdateViewStatus.init:
              case FolderUpdateViewStatus.loading:
                return const TodoLoading();
              case FolderUpdateViewStatus.success:
              case FolderUpdateViewStatus.faiure:
              case FolderUpdateViewStatus.completed:
              case FolderUpdateViewStatus.leave:
            }
            final taskItem = state.folder;
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              children: [
                titleTextField(
                  folder: taskItem,
                  titleController: state.titleController,
                ),
                const SizedBox(height: 16.0),
                // labelPicker(
                //   taskItem: taskItem,
                //   labelList: state.labelList,
                //   selectedLabelList: taskItem.labelIndexList,
                // ),
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
