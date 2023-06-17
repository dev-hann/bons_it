import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/view/label_view/view/label_select_view/bloc/label_select_bloc.dart';
import 'package:bons_it/view/label_view/view/label_update_view/label_update_view.dart';
import 'package:bons_it/widget/label_list_tile.dart';

class LabelSelectView extends StatefulWidget {
  const LabelSelectView({
    super.key,
    this.labelIndexList = const [],
  });
  final List<String> labelIndexList;

  static MaterialPageRoute<List<String>> route({
    List<String> selectedLabelList = const [],
  }) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => LabelSelectBloc(
          RepositoryProvider.of<TaskRepo>(context),
        ),
        child: LabelSelectView(
          labelIndexList: selectedLabelList,
        ),
      );
    });
  }

  @override
  State<LabelSelectView> createState() => _LabelSelectViewState();
}

class _LabelSelectViewState extends State<LabelSelectView> {
  LabelSelectBloc get bloc => BlocProvider.of<LabelSelectBloc>(context);

  @override
  void initState() {
    super.initState();
    bloc.add(LabelSelectEventStarted(widget.labelIndexList));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Choose Label"),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop(bloc.state.selectedList);
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              LabelUpdateView.route(),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget traingWidget({
    required String labelIndex,
    required bool isSelected,
  }) {
    return Checkbox(
      value: isSelected,
      onChanged: (value) {
        bloc.add(
          LabelSelectEventOnTapSelected(labelIndex),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocBuilder<LabelSelectBloc, LabelSelectState>(
        builder: (context, state) {
          final list = state.labelList;
          final selectedList = state.selectedList;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              final label = list[index];
              final labelIndex = label.index;
              return LabelListTile(
                label: label,
                onTap: () {
                  Navigator.of(context).push(
                    LabelUpdateView.route(label: label),
                  );
                },
                trailing: traingWidget(
                  labelIndex: labelIndex,
                  isSelected: selectedList.contains(labelIndex),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
