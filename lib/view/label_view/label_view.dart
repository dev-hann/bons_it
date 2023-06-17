import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bons_it/view/label_view/bloc/label_bloc.dart';
import 'package:bons_it/view/label_view/view/label_update_view/label_update_view.dart';
import 'package:bons_it/widget/label_list_tile.dart';

class LabelView extends StatefulWidget {
  const LabelView({super.key});

  @override
  State<LabelView> createState() => _LabelViewState();
}

class _LabelViewState extends State<LabelView> {
  LabelBloc get bloc => BlocProvider.of<LabelBloc>(context);

  @override
  void initState() {
    super.initState();
    bloc.add(LabelEventStarted());
  }

  FloatingActionButton updateButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          LabelUpdateView.route(),
        );
      },
      child: const Icon(Icons.label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: updateButton(),
      body: BlocBuilder<LabelBloc, LabelState>(
        builder: (context, state) {
          final list = state.labelList;
          if (list.isEmpty) {
            return const Text("Empty");
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              final label = list[index];
              return Card(
                child: LabelListTile(
                  label: label,
                  onTap: () {
                    Navigator.of(context).push(
                      LabelUpdateView.route(
                        label: label,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
