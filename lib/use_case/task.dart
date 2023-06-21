import 'package:bons_it/model/todo_folder.dart';
import 'package:dartz/dartz.dart';
import 'package:bons_it/model/error.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/repository/task/task_repo.dart';

class TaskUseCase {
  TaskUseCase(this.repo);
  final TaskRepo repo;

  // Task
  Stream<String> taskStream() {
    return repo.folderStream();
  }

  Future<Either<BSError, List<TodoFolder>>> requestTodoFolderList() async {
    try {
      final list = await repo.requestTodoFolderList();
      return Right(
        list.map((e) => TodoFolder.fromMap(e)).toList(),
      );
    } catch (e) {
      return Left(BSError.fromException(e));
    }
  }

  Future<Either<BSError, TodoFolder?>> requestTodoFolder(String index) async {
    try {
      final data = await repo.requestTodoFolder(index);
      if (data == null) {
        return const Right(null);
      }
      return Right(TodoFolder.fromMap(data));
    } catch (e) {
      return Left(BSError.fromException(e));
    }
  }

  Future<Option<BSError>> updateTodoFolder(TodoFolder folder) async {
    try {
      await repo.updateTodoFolder(folder.index, folder.toMap());
      return const None();
    } catch (e) {
      return Some(BSError.fromException(e));
    }
  }

  Future<Option<BSError>> removeTodoFolder(String index) async {
    try {
      await repo.removeTodoFolder(index);
      return const None();
    } catch (e) {
      return Some(BSError.fromException(e));
    }
  }

  // Future<Either<BSError, TodoItem?>> requestTaskItem(String index) async {
  //   try {
  //     final data = await repo.requestTaskItem(index);
  //     if (data == null) {
  //       return const Right(null);
  //     }
  //     return Right(TodoItem.fromMap(data));
  //   } catch (e) {
  //     return Left(BSError.fromException(e));
  //   }
  // }

  // Future<Either<BSError, List<TodoItem>>> reqeustTskItemList() async {
  //   try {
  //     final listData = await repo.requestTskItemList();
  //     return Right(listData.map((e) => TodoItem.fromMap(e)).toList());
  //   } catch (e) {
  //     return Left(BSError.fromException(e));
  //   }
  // }

  // Future<Option<BSError>> updateTaskItem(TodoItem item) async {
  //   try {
  //     await repo.updateTaskItem(item.index, item.toMap());
  //     return const None();
  //   } catch (e) {
  //     return Some(BSError.fromException(e));
  //   }
  // }

  // Future<Option<BSError>> removeTaskItem(String index) async {
  //   try {
  //     await repo.removeTaskItem(index);
  //     return const None();
  //   } catch (e) {
  //     return Some(BSError.fromException(e));
  //   }
  // }

  // Future<Either<BSError, List<TodoItem>>> requestTaskItemList() async {
  //   try {
  //     final listData = await repo.requestTskItemList();
  //     return Right(listData.map((e) => TodoItem.fromMap(e)).toList());
  //   } catch (e) {
  //     return Left(BSError.fromException(e));
  //   }
  // }

  // Label
  Stream<String> labelStream() {
    return repo.labelStream();
  }

  Future<Either<BSError, List<Label>>> requestLabelList() async {
    try {
      final listData = await repo.requestLabelList();
      return Right(listData.map((e) => Label.fromMap(e)).toList());
    } catch (e) {
      return Left(BSError.fromException(e));
    }
  }

  Future<Either<BSError, Label?>> requestLabel(String index) async {
    try {
      final data = await repo.reqeustLabel(index);
      if (data == null) {
        return const Right(null);
      }
      return Right(Label.fromMap(data));
    } catch (e) {
      return Left(BSError.fromException(e));
    }
  }

  Future<Option<BSError>> updateLabel(Label label) async {
    try {
      await repo.updateLabel(label.index, label.toMap());
      return const None();
    } catch (e) {
      return Some(BSError.fromException(e));
    }
  }

  Future<Option<BSError>> removeLabel(String index) async {
    try {
      await repo.removeLabel(index);
      return const None();
    } catch (e) {
      return Some(BSError.fromException(e));
    }
  }
}
