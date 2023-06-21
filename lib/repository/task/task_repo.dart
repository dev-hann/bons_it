import 'dart:async';

part 'task_impl.dart';

abstract class TaskRepo {
  // Task
  Stream<String> folderStream();

  Future<List<dynamic>> requestTodoFolderList();

  Future<dynamic> requestTodoFolder(String index);

  Future updateTodoFolder(String index, Map<String, dynamic> map);

  Future removeTodoFolder(String index);

  // Label
  Stream<String> labelStream();

  Future<dynamic> reqeustLabel(String index);

  Future<List<dynamic>> requestLabelList();

  Future updateLabel(String index, Map<String, dynamic> data);

  Future removeLabel(String index);
}
