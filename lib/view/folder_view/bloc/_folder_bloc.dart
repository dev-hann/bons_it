// editoer bug? can not make file name to snake_case
import 'package:bloc/bloc.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:equatable/equatable.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  FolderBloc(TaskRepo repo) : super(FolderInitial()) {}
}
