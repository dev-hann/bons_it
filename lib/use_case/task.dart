import 'package:dartz/dartz.dart';
import 'package:bons_it/model/error.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/model/task_item.dart';
import 'package:bons_it/repository/task/task_repo.dart';

class TaskUseCase {
  TaskUseCase(this.repo);
  final TaskRepo repo;

  // Task
  Stream<String> taskStream() {
    return repo.taskStream();
  }

  Future<Either<TodoError, TaskItem?>> requestTaskItem(String index) async {
    try {
      final data = await repo.requestTaskItem(index);
      if (data == null) {
        return const Right(null);
      }
      return Right(TaskItem.fromMap(data));
    } catch (e) {
      return Left(TodoError.fromException(e));
    }
  }

  Future<Either<TodoError, List<TaskItem>>> reqeustTskItemList() async {
    try {
      final listData = await repo.requestTskItemList();
      return Right(listData.map((e) => TaskItem.fromMap(e)).toList());
    } catch (e) {
      return Left(TodoError.fromException(e));
    }
  }

  Future<Option<TodoError>> updateTaskItem(TaskItem item) async {
    try {
      await repo.updateTaskItem(item.index, item.toMap());
      return const None();
    } catch (e) {
      return Some(TodoError.fromException(e));
    }
  }

  Future<Option<TodoError>> removeTaskItem(String index) async {
    try {
      await repo.removeTaskItem(index);
      return const None();
    } catch (e) {
      return Some(TodoError.fromException(e));
    }
  }

  Future<Either<TodoError, List<TaskItem>>> requestTaskItemList() async {
    try {
      final listData = await repo.requestTskItemList();
      return Right(listData.map((e) => TaskItem.fromMap(e)).toList());
    } catch (e) {
      return Left(TodoError.fromException(e));
    }
  }

  // Label
  Stream<String> labelStream() {
    return repo.labelStream();
  }

  Future<Either<TodoError, List<Label>>> requestLabelList() async {
    try {
      final listData = await repo.requestLabelList();
      return Right(listData.map((e) => Label.fromMap(e)).toList());
    } catch (e) {
      return Left(TodoError.fromException(e));
    }
  }

  Future<Either<TodoError, Label?>> requestLabel(String index) async {
    try {
      final data = await repo.reqeustLabel(index);
      if (data == null) {
        return const Right(null);
      }
      return Right(Label.fromMap(data));
    } catch (e) {
      return Left(TodoError.fromException(e));
    }
  }

  Future<Option<TodoError>> updateLabel(Label label) async {
    try {
      await repo.updateLabel(label.index, label.toMap());
      return const None();
    } catch (e) {
      return Some(TodoError.fromException(e));
    }
  }

  Future<Option<TodoError>> removeLabel(String index) async {
    try {
      await repo.removeLabel(index);
      return const None();
    } catch (e) {
      return Some(TodoError.fromException(e));
    }
  }
}
