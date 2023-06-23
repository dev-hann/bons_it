import 'package:bons_it/view/home_view/bloc/home_bloc.dart';
import 'package:bons_it/view/runner_view/bloc/runner_bloc.dart';
import 'package:bons_it/widget/circle_track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeBloc get homeBloc => BlocProvider.of(context);
  RunnerBloc get runnerBloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeEventStarted());
    runnerBloc.add(RunnerEventStarted());
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Bons It"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  Widget clockButton({
    required HomeViewStatus status,
    required VoidCallback onTapStart,
    required VoidCallback onTapStop,
  }) {
    if (status == HomeViewStatus.running) {
      return ElevatedButton(
        onPressed: onTapStop,
        child: const Text("Stop"),
      );
    }
    return ElevatedButton(
      onPressed: onTapStart,
      child: const Text("Start"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final status = state.status;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.width / 2,
                    child: CircleTrack(
                      currentDuration: state.currentDuration,
                      totalDuration: state.totalDuration,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  clockButton(
                    status: status,
                    onTapStart: () {
                      runnerBloc.add(RunnerEventRan());
                      homeBloc.add(HomeEventClockStarted());
                    },
                    onTapStop: () {
                      runnerBloc.add(RunnerEventRested());
                      homeBloc.add(HomeEventClockStopped());
                    },
                  ),
                  const SizedBox(height: 8.0),
                  ColoredBox(
                    color: Colors.red,
                    child: SizedBox(
                      width: size.width,
                      height: size.height / 3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
