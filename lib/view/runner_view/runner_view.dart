import 'package:bons_it/view/runner_view/bloc/runner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RunnerView extends StatefulWidget {
  const RunnerView({super.key});

  @override
  State<RunnerView> createState() => _RunnerViewState();
}

class _RunnerViewState extends State<RunnerView> {
  RunnerBloc get bloc => BlocProvider.of<RunnerBloc>(context);
  @override
  void initState() {
    super.initState();
    bloc.add(RunnerEventStarted());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.add(
      RunnerEventUpdated(bloc.state.runner, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RunnerBloc, RunnerState>(
      builder: (context, state) {
        return Image.asset(
          state.runnerImage,
          width: 56.0,
        );
      },
    );
  }
}
