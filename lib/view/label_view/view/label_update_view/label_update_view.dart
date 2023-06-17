import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/view/label_view/view/label_update_view/bloc/label_update_bloc.dart';

class LabelUpdateView extends StatefulWidget {
  const LabelUpdateView({
    super.key,
    required this.label,
  });
  final Label? label;

  static MaterialPageRoute route({
    Label? label,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => LabelUpdateBloc(
            RepositoryProvider.of<TaskRepo>(context),
          ),
          child: LabelUpdateView(
            label: label,
          ),
        );
      },
    );
  }

  @override
  State<LabelUpdateView> createState() => _LabelUpdateViewState();
}

class _LabelUpdateViewState extends State<LabelUpdateView> {
  LabelUpdateBloc get bloc => BlocProvider.of<LabelUpdateBloc>(context);

  @override
  void initState() {
    super.initState();
    bloc.add(LabelUpdateStarted(widget.label));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Update Label"),
    );
  }

  Widget labelNameWidget({
    required TextEditingController nameController,
  }) {
    return TextField(
      controller: nameController,
    );
  }

  Widget labelColorWidget() {
    return const SizedBox();
  }

  Widget updateButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          bloc.add(
            LabelUpdateCompleted(),
          );
        },
        child: const Text("Update"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocListener<LabelUpdateBloc, LabelUpdateState>(
        listener: (context, state) {
          if (state.status == LabelUpdateViewStatus.completed) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<LabelUpdateBloc, LabelUpdateState>(
          builder: (context, state) {
            return ListView(
              children: [
                labelNameWidget(nameController: state.nameController),
                updateButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
